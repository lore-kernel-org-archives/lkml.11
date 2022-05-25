Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2C0C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 10:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiEYKNN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiEYKNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:13:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A52A266A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653473590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bnltgLXeKWoUnemqwWYQLBeIqRsC67zVzmNXg0YgPHo=;
        b=H7BgvSD2+S3vjHih45RfsXoiyVFtg8ZR0Ts09KpvXm3fgRLyzDF4TTr2k4/VjundLlM6n0
        M1IRMkofAlTTEnvshe38khYs18jsAAmLz8baZz3I1ajJ6Dw+HbQKG7No6jEe1zw2kNZ5fU
        ZywnhcqRZUy/Z9uIARGhJXcAnAtO7ZE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-zxXxVHltNy-4j34_bjsREg-1; Wed, 25 May 2022 06:13:08 -0400
X-MC-Unique: zxXxVHltNy-4j34_bjsREg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B2E1858EED;
        Wed, 25 May 2022 10:13:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9834492C3B;
        Wed, 25 May 2022 10:13:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
cc:     dhowells@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org
Subject: checkpatch mistake on XA_STATE?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1962594.1653473587.1@warthog.procyon.org.uk>
Date:   Wed, 25 May 2022 11:13:07 +0100
Message-ID: <1962595.1653473587@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see the following:

	WARNING: Missing a blank line after declarations
	#1921: FILE: fs/cifs/smb2ops.c:4684:
	+       struct folio *folio;
	+       XA_STATE(xas, buffer, 0);

but XA_STATE() technically *is* a declaration.

Should checkpatch treat it as such?

David

