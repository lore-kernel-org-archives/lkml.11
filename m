Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A865C4167D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 14:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348734AbiCUONx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348579AbiCUOGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CB9538BDD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647871312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e08TBu9LXeju0JfJXQDlbeITBDevreGVnW43wNE54QU=;
        b=BbLMlC4qYcZq6m5/4hva+u+LQsJ9mogro+Rgaa+jVFBXJnmC/Vk58CQ0Iu4xoYdVCjQwZV
        pCLmnXdA+rsrcWiBmwVSkYzQ8fu0xwEyOWk/Rchhbi+5nurWQHh8zGYq5XW2trqA+NLOjG
        oYKpTrMsUnpZ1UULX6EiH6dBuR25F9c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-H3oEy_SQPG2zWEEw1fs1Sw-1; Mon, 21 Mar 2022 10:01:46 -0400
X-MC-Unique: H3oEy_SQPG2zWEEw1fs1Sw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CCF028035F1;
        Mon, 21 Mar 2022 14:01:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5DB92166B2D;
        Mon, 21 Mar 2022 14:01:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220316131723.111553-5-jefflexu@linux.alibaba.com>
References: <20220316131723.111553-5-jefflexu@linux.alibaba.com> <20220316131723.111553-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com
Subject: Re: [PATCH v5 04/22] cachefiles: notify user daemon with anon_fd when looking up cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1029247.1647871294.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 21 Mar 2022 14:01:34 +0000
Message-ID: <1029248.1647871294@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> +	read_lock(&cache->reqs_lock);
> +
> +	/* recheck dead state under lock */
> +	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
> +		read_unlock(&cache->reqs_lock);
> +		ret =3D -EIO;
> +		goto out;
> +	}
> +
> +	xa_lock(xa);
> +	ret =3D __xa_alloc(xa, &id, req, xa_limit_32b, GFP_KERNEL);

You're holding a spinlock.  You can't use GFP_KERNEL.

> +static int cachefiles_ondemand_cinit(struct cachefiles_cache *cache, ch=
ar *args)
> +{
> ...
> +	tmp =3D kstrdup(args, GFP_KERNEL);

No need to copy the string.  The caller already did that and added a NUL f=
or
good measure.

I would probably move most of the functions added in this patch to
fs/cachefiles/ondemand.c.

David

