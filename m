Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6ECC4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 16:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355404AbiDSQ4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 12:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347390AbiDSQuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9A183AA4D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650386827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BWvAKy8LocH47YhakvpIBQwKMnIJQQng3vxQEYIL7zc=;
        b=VX9Lea2KWKzJbjxUJB+5eNsXFpCLEh2LP7F4CyPIdOU1zFfTPqSS2LoYo0YSoNfkgMna/l
        wBH6fgiAxG90QkwsxU6bRgklaiCJVMoqE5EQsMdYVfcXV1ETi5SEqAXrjQdn1DBJwuliqu
        C4SVV9PSezIi3S8OhVzbYj3AfM4UvRw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-EaA8j95MOtSsSpdXOLr65A-1; Tue, 19 Apr 2022 12:47:03 -0400
X-MC-Unique: EaA8j95MOtSsSpdXOLr65A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34F563820F64;
        Tue, 19 Apr 2022 16:47:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B4A740E80E0;
        Tue, 19 Apr 2022 16:47:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yl7mQr05hPg4vELb@rabbit.intern.cm-ag>
References: <Yl7mQr05hPg4vELb@rabbit.intern.cm-ag> <Yl7EyMLnqqDv63yW@rabbit.intern.cm-ag> <YlWWbpW5Foynjllo@rabbit.intern.cm-ag> <454834.1650373340@warthog.procyon.org.uk> <508603.1650385022@warthog.procyon.org.uk>
To:     Max Kellermann <mk@cm4all.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fscache corruption in Linux 5.17?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <510135.1650386821.1@warthog.procyon.org.uk>
Date:   Tue, 19 Apr 2022 17:47:01 +0100
Message-ID: <510136.1650386821@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max Kellermann <mk@cm4all.com> wrote:

> I don't think any write is misaligned.  This was triggered by a
> WordPress update, so I think the WordPress updater truncated and
> rewrote all files.  Random guess: some pages got transferred to the
> NFS server, but the local copy in fscache did not get updated.

Do the NFS servers change the files that are being served - or is it just
WordPress pushing the changes to the NFS servers for the web servers to then
export?

David

