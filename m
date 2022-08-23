Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21225C32774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 08:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbiHWIWs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243081AbiHWIQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21540C6D;
        Tue, 23 Aug 2022 01:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1F38612DA;
        Tue, 23 Aug 2022 08:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D893C433D6;
        Tue, 23 Aug 2022 08:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661242275;
        bh=VBY8pSavty0a8/be3ESWT8pu5JPwtob0ZB5UChZI1Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TvrNcQFl8RqnBoekP9GA5ksXnvjzJXIUQhkPIgHRaCXuL88w2r6+e4RIkMfZnHqoo
         eMbISDkG7BZjwqlPfJ4veHP9x8Z/cEnRaQJkjm2R0KXvLCYw4DgMGLquo/RAY/D0JD
         0es6HQ+EU7mMYRwWsuoNWmC9COzMbMJDWubAFRY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, mingi cho <mgcho.minic@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.9 046/101] netfilter: nf_tables: fix null deref due to zeroed list head
Date:   Tue, 23 Aug 2022 10:03:19 +0200
Message-Id: <20220823080036.308057139@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080034.579196046@linuxfoundation.org>
References: <20220823080034.579196046@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

commit 580077855a40741cf511766129702d97ff02f4d9 upstream.

In nf_tables_updtable, if nf_tables_table_enable returns an error,
nft_trans_destroy is called to free the transaction object.

nft_trans_destroy() calls list_del(), but the transaction was never
placed on a list -- the list head is all zeroes, this results in
a null dereference:

BUG: KASAN: null-ptr-deref in nft_trans_destroy+0x26/0x59
Call Trace:
 nft_trans_destroy+0x26/0x59
 nf_tables_newtable+0x4bc/0x9bc
 [..]

Its sane to assume that nft_trans_destroy() can be called
on the transaction object returned by nft_trans_alloc(), so
make sure the list head is initialised.

Fixes: 55dd6f93076b ("netfilter: nf_tables: use new transaction infrastructure to handle table")
Reported-by: mingi cho <mgcho.minic@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -119,6 +119,7 @@ static struct nft_trans *nft_trans_alloc
 	if (trans == NULL)
 		return NULL;
 
+	INIT_LIST_HEAD(&trans->list);
 	trans->msg_type = msg_type;
 	trans->ctx	= *ctx;
 


