Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28ECC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 09:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346759AbiCOJnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 05:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346737AbiCOJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 736614EF5D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647337350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ds972m32UsHYPTXO2zaE7harfTeBM/jXF+brjmWcEJU=;
        b=Sk9AE5DjhirNDBdoXcs411BYKYZf5z3c9cCQbtGBeN9ITOIrra1CCBZJZ47rou4RkL9Lme
        ESRiOoDnXeJ2jIEf6BpNEavMXXWt6WC1SARck0cFdN8JaC9U9X2bnZy6dQ81+cwjiI39zh
        OYJ3c3Ic93eMD9lUqRmDVETowhWOdr0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-H8ScW7y_NtqJB7xwVc6PjQ-1; Tue, 15 Mar 2022 05:42:29 -0400
X-MC-Unique: H8ScW7y_NtqJB7xwVc6PjQ-1
Received: by mail-qv1-f71.google.com with SMTP id dj3-20020a056214090300b004354a9c60aaso16188180qvb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ds972m32UsHYPTXO2zaE7harfTeBM/jXF+brjmWcEJU=;
        b=wmLLShUNoMpZvz04YE+f0IDALleaEjYeCWhxbnU9W0qmP5Y/twgpMBbrmao7yDQ5iw
         +1lvO7XzRJz9gEEUULPAT5SKmU6g811HlN9p2gcPdPAqsAjPrxoXST+rG/D377tbYZ7A
         xWR1HdlThx5bW7SX4uU5V6YIfUhGy9gcB5G+dkD9QYMOoBgQtdg9Kv0wYdlkQRi8hQ+C
         7S/HanWmLVtZxOSp6dqFXJAoWRnmGsi6qGGt0fT7S9uWVmofehnZERI0JNIt2O/v8x6n
         BGSyfvzrnUh3RkIVpYXCBAUYSS3ouHmJz9CroPybzKKKOe7XaazGJKObscpzOaJp6eMh
         JayQ==
X-Gm-Message-State: AOAM532en/8NUmiuIPQijSXQZxM388FPU2kAiiuCSyshU7iSTKpXiA7T
        6V6HA4dTyvF5JXqVOxZhpWRfIQlLQbfIF9eFOLxGg/ridsv5S2tKfg2B7uGPREX+/ga57HRbnp3
        BTxq0mbFnk3jCG3FSGul9jLXr
X-Received: by 2002:a05:6214:c6d:b0:440:ac02:7780 with SMTP id t13-20020a0562140c6d00b00440ac027780mr6806435qvj.3.1647337349127;
        Tue, 15 Mar 2022 02:42:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz42nBONUMqEZ4XOsuNGpVckpNWadr0jR4fGhO7CwI1fHw6DycfxJ/bVDSIU0KjGdkQQBH4Ag==
X-Received: by 2002:a05:6214:c6d:b0:440:ac02:7780 with SMTP id t13-20020a0562140c6d00b00440ac027780mr6806421qvj.3.1647337348926;
        Tue, 15 Mar 2022 02:42:28 -0700 (PDT)
Received: from sgarzare-redhat (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
        by smtp.gmail.com with ESMTPSA id u19-20020a05622a199300b002e1a669eeb6sm11762076qtc.34.2022.03.15.02.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 02:42:28 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:42:22 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com,
        arei.gonglei@huawei.com, yechuan@huawei.com,
        huangzhichao@huawei.com, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/3] vdpa: change the type of nvqs to u32
Message-ID: <20220315094222.nbrknj5lqtqnbvmt@sgarzare-redhat>
References: <20220315032553.455-1-longpeng2@huawei.com>
 <20220315032553.455-3-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220315032553.455-3-longpeng2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 11:25:52AM +0800, Longpeng(Mike) wrote:
>From: Longpeng <longpeng2@huawei.com>
>
>Change vdpa_device.nvqs and vhost_vdpa.nvqs to use u32
>
>Signed-off-by: Longpeng <longpeng2@huawei.com>
>---
> drivers/vdpa/vdpa.c  |  6 +++---
> drivers/vhost/vdpa.c | 10 ++++++----
> include/linux/vdpa.h |  6 +++---
> 3 files changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

