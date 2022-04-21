Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAD8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 14:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388657AbiDUOFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 10:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386439AbiDUOF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99C053A5D4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650549745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aPltoNX3v1MHdmgBq0oIkCAldNZyXJBcZt6C3pWO+9Q=;
        b=Ae16fq2DK+53wxe9VFpG3bbRhVpp297Ke8U9CahCGrGQBisLegYK5WKyXtjaNEJMBStx8v
        1wRTmecqhOT+xr6GmpiFJsssp+Bht2VcD3I2AKqoztsIs4vhiUXxstzZZ8SgLs9asy4d13
        5kteeiL3izVAtUPujnmEpYDnW2TvCcA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-VGILzSB1Pqmxx7WgsHszIg-1; Thu, 21 Apr 2022 10:02:24 -0400
X-MC-Unique: VGILzSB1Pqmxx7WgsHszIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0503F811E76;
        Thu, 21 Apr 2022 14:02:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B44340CFD22;
        Thu, 21 Apr 2022 14:02:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220415123614.54024-4-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-4-jefflexu@linux.alibaba.com> <20220415123614.54024-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
Subject: Re: [PATCH v9 03/21] cachefiles: unbind cachefiles gracefully in on-demand mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1444915.1650549738.1@warthog.procyon.org.uk>
Date:   Thu, 21 Apr 2022 15:02:18 +0100
Message-ID: <1444916.1650549738@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> +	struct kref			unbind_pincount;/* refcount to do daemon unbind */

Please use refcount_t or atomic_t, especially as this isn't the refcount for
the structure.

> -	cachefiles_daemon_unbind(cache);
> -
>  	/* clean up the control file interface */
>  	cache->cachefilesd = NULL;
>  	file->private_data = NULL;
>  	cachefiles_open = 0;

Please call cachefiles_daemon_unbind() before the cleanup.

David

