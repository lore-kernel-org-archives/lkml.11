Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC1AECAAD3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 08:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiIAIH5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 04:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiIAIHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:07:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B366120FBE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662019667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ktasy/sEA81Y05abLwyFqQvcTxn1i+/4USQhNLHaRD4=;
        b=axsXwVsJNXafPs837HQb/tWKPbkXqleSzgS7kB3mLkRkDMSkMWjg/mQXuBHfpPxldd3cYu
        r4QQCP1xdgVkgY/pTGyryzBBLk5J2QAWG5bnI9XSyDybctVzaPJVyNLBQG9Jwv1xMB5HfC
        sIKrQeIvt4mdG3vokKC2i2i2pn2qfKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-qsdJlGBaObe0IXJQ7EZ25g-1; Thu, 01 Sep 2022 04:07:45 -0400
X-MC-Unique: qsdJlGBaObe0IXJQ7EZ25g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5882210726A2;
        Thu,  1 Sep 2022 08:07:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF81AC15BBA;
        Thu,  1 Sep 2022 08:07:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 3/6] rxrpc: Fix local destruction being repeated
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Sep 2022 09:07:44 +0100
Message-ID: <166201966425.3817988.9780080415265800940.stgit@warthog.procyon.org.uk>
In-Reply-To: <166201964443.3817988.12088441548413332725.stgit@warthog.procyon.org.uk>
References: <166201964443.3817988.12088441548413332725.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the local processor work item for the rxrpc local endpoint gets requeued
by an event (such as an incoming packet) between it getting scheduled for
destruction and the UDP socket being closed, the rxrpc_local_destroyer()
function can get run twice.  The second time it can hang because it can end
up waiting for cleanup events that will never happen.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/local_object.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 79bb02eb67b2..38ea98ff426b 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -406,6 +406,9 @@ static void rxrpc_local_processor(struct work_struct *work)
 		container_of(work, struct rxrpc_local, processor);
 	bool again;
 
+	if (local->dead)
+		return;
+
 	trace_rxrpc_local(local->debug_id, rxrpc_local_processing,
 			  refcount_read(&local->ref), NULL);
 


