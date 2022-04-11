Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29706C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 12:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346122AbiDKMq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 08:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbiDKMq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:46:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1E4015FDE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649681081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3D5twS6fI8upjNFbaq7L4RyTo/YSaqC5qUAqNUSSRk=;
        b=YpgNpxYy1mbkRVy/O2dnDrMJHb7EoggFM2YOQsnpnHanH608Nom2joR+0ZsRXik8zMHMA1
        Rlp4D+5LwYrydehgKWBlaWeLR2nD9uCIn9wJDMijIkn3/WUjQHFORz/f6/d08REvtdUyjB
        +IHpKY8ZqgeMOo57motIm4iwq+Uqb5w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-xIvNM0C2OXKCHP56sbKC7w-1; Mon, 11 Apr 2022 08:44:38 -0400
X-MC-Unique: xIvNM0C2OXKCHP56sbKC7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 546293802AC2;
        Mon, 11 Apr 2022 12:44:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF59C40CFD0F;
        Mon, 11 Apr 2022 12:44:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220406075612.60298-6-jefflexu@linux.alibaba.com>
References: <20220406075612.60298-6-jefflexu@linux.alibaba.com> <20220406075612.60298-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: Re: [PATCH v8 05/20] cachefiles: implement on-demand read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1091904.1649681074.1@warthog.procyon.org.uk>
Date:   Mon, 11 Apr 2022 13:44:34 +0100
Message-ID: <1091905.1649681074@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

>  	/*
>  	 * Uninstall anon_fd to the cachefiles object, so that no further
>  	 * associated requests will get enqueued.
>  	 */

"Uninstall anon_fd from..."?

> +static int init_read_req(struct cachefiles_req *req, void *private)

Prefix with "cachefiles_" please (or "cachefiles_ondemand_").

David

