Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB23C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 08:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiBVILr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 03:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiBVILm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:11:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86C84151D10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645517474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G0GfwrcLD4lf4ANifuaF1OYMcDG4+GeX0AlNzDkoZxA=;
        b=GPGPbJ8g9m5ZNPRlCjNidVBUlgY+hGZagwh7L1qGGuvb0JpRSmPKWz+rQh6EskDlXKCw92
        0ieNXpPp3bnuaC+y7gOsxD9F279JNOwyn/IoAvCz5jKlNT7Lhn1qnjajt8ziygF1WBNb9h
        3hyCovAZNadPFiIaiZLOS257/SGRPHI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-UE2Uv2rNPqmq66h1FZpQfg-1; Tue, 22 Feb 2022 03:11:12 -0500
X-MC-Unique: UE2Uv2rNPqmq66h1FZpQfg-1
Received: by mail-qv1-f72.google.com with SMTP id fq2-20020a056214258200b0042c39c09e5dso20086272qvb.18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G0GfwrcLD4lf4ANifuaF1OYMcDG4+GeX0AlNzDkoZxA=;
        b=1jA9jAdrgWtDjuX8qEPa4V1c5w1KOIp8KAJoBYJdleetlNFKTpZ7AD8NuPzjjBAQ/M
         Fx78NZq5Lg52dXiLWp6h30McLs0g97s3o8XoPopuJiSyhrBq4B+bjEEOtsOnDh4F8FNV
         MUldwKrspwaP/hUh4BvN4qpdzHiLVrn8OqdKiSPpmVEnDYwNImpzexBMJGXBVYGzYA2P
         PSnSEvq4ivlU/LGOf7OQH/Ydwtz0W20ImbkhG7Qz7UNuw+hEfL9/k8B1fFmGf3WtM1ya
         uUGg9+7IAiJV6ZW2r9CGND3EoFruf7CYSWtVt0YINLB1qVLdxkGAjMD/Y3H+Z+5AvarU
         YwLQ==
X-Gm-Message-State: AOAM531LOv+xBGQFRy+OfIF+Dc7m+zhwWXCYRgs7E1uSB080tjjsWHX/
        8GgXd7GOj5Fs5iT6Yrea+ovEudJP/a39Y51vE4k1T7JrKJ1ObnpC4NEyx367yvCsXVhHJ+LhpAm
        0e2Gz3BUCAcSVL9dN2xI+3xaL
X-Received: by 2002:a05:620a:3706:b0:648:afb4:5794 with SMTP id de6-20020a05620a370600b00648afb45794mr8516393qkb.433.1645517471387;
        Tue, 22 Feb 2022 00:11:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6pPGdI38EWvdExU9PjVYF+abcYYxcjPH+D5uHZtUns1W/zgUWgRUc58bwXKp5JDZUPsdCOQ==
X-Received: by 2002:a05:620a:3706:b0:648:afb4:5794 with SMTP id de6-20020a05620a370600b00648afb45794mr8516386qkb.433.1645517471142;
        Tue, 22 Feb 2022 00:11:11 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it. [95.248.229.156])
        by smtp.gmail.com with ESMTPSA id n16sm5744274qkn.115.2022.02.22.00.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 00:11:10 -0800 (PST)
Date:   Tue, 22 Feb 2022 09:11:04 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, "Michael S. Tsirkin" <mst@redhat.com>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        Asias He <asias@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: don't check owner in vhost_vsock_stop()
 while releasing
Message-ID: <20220222081104.a2woahjgno2iv7yl@sgarzare-redhat>
References: <20220221114916.107045-1-sgarzare@redhat.com>
 <202202220707.AM3rKUcP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202202220707.AM3rKUcP-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:30:17AM +0300, Dan Carpenter wrote:
>Hi Stefano,
>
>url:    https://github.com/0day-ci/linux/commits/Stefano-Garzarella/vhost-vsock-don-t-check-owner-in-vhost_vsock_stop-while-releasing/20220221-195038
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
>config: x86_64-randconfig-m031-20220221 (https://download.01.org/0day-ci/archive/20220222/202202220707.AM3rKUcP-lkp@intel.com/config)
>compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>
>If you fix the issue, kindly add following tag as appropriate
>Reported-by: kernel test robot <lkp@intel.com>
>Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
>smatch warnings:
>drivers/vhost/vsock.c:655 vhost_vsock_stop() error: uninitialized symbol 'ret'.
>
>vim +/ret +655 drivers/vhost/vsock.c
>
>3ace84c91bfcde Stefano Garzarella 2022-02-21  632  static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
>433fc58e6bf2c8 Asias He           2016-07-28  633  {
>433fc58e6bf2c8 Asias He           2016-07-28  634  	size_t i;
>433fc58e6bf2c8 Asias He           2016-07-28  635  	int ret;
>433fc58e6bf2c8 Asias He           2016-07-28  636
>433fc58e6bf2c8 Asias He           2016-07-28  637  	mutex_lock(&vsock->dev.mutex);
>433fc58e6bf2c8 Asias He           2016-07-28  638
>3ace84c91bfcde Stefano Garzarella 2022-02-21  639  	if (check_owner) {
>433fc58e6bf2c8 Asias He           2016-07-28  640  		ret = vhost_dev_check_owner(&vsock->dev);
>433fc58e6bf2c8 Asias He           2016-07-28  641  		if (ret)
>433fc58e6bf2c8 Asias He           2016-07-28  642  			goto err;
>3ace84c91bfcde Stefano Garzarella 2022-02-21  643  	}
>
>"ret" not initialized on else path.

Oooops, I was testing with vhost_vsock_dev_release() where we don't 
check the ret value, but of course we need to initialize it to 0 for the 
vhost_vsock_dev_ioctl() use case.

I'll fix in the v2.

Thanks for the report,
Stefano

