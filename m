Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0942C3527C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 09:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387049AbiDLJFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 05:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376376AbiDLHn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1C0E4616D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649748499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iF6/C1RHwf7CTYQOQSnv8azPGC+3cM41Uv4y73pmXAM=;
        b=Tmevb8X/88SfFPaIY/6VxLTKIYkMpb+1K6HqBw1b3oceNH9BkJ2XxQETbdnNQTCAAhrJyO
        WERd3xEmlSGi/Wwgw6ctnx2MlpEocP/DTvmEmWrjOPdNYzhoJWRxikF90owCGH6mUAPc0v
        24YplLFyMfdMZJRebVgtiu1fhzi4y8I=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-MarEpLgGPrudXiXGS3pJWg-1; Tue, 12 Apr 2022 03:28:17 -0400
X-MC-Unique: MarEpLgGPrudXiXGS3pJWg-1
Received: by mail-qt1-f199.google.com with SMTP id z3-20020ac86b83000000b002ed0f18c23cso6104354qts.17
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=iF6/C1RHwf7CTYQOQSnv8azPGC+3cM41Uv4y73pmXAM=;
        b=CvavYFKGGJwcmokt1I1ukao/6JBoHOViieuKn7hMcq5nObS1g6zCBZSsTdr0kF/Z1S
         74cYpoBuxfJjFFRoQZX3lY9RAqDdY8GQUbzOXxxT1B1XGl1UW2KOusvLzCtaL0mlXMet
         2GxPQDOLfZXjNNEhiy1lSz3fC1gYWtC8wXjRsgSBXNIbWk+hbsBO9jUuQ4zM2Y79QgmX
         qb9x/Av54Tj5HgdUtYyZrRc9I6kiNeblBYhfiWrElx7BK1XhArAX6Xs8efuA5xWwACci
         USC7Jg5+AV+LIzzQt3eBVOFJRCrGrpZhf6tfuu1i3Wwo1fEFnjiYv31TmJLNlO6Cxm17
         Chzg==
X-Gm-Message-State: AOAM531BSMTnwvXvmy9PON64Rzc/S7oga/+pYOlqutCNjl6V0CYpddU0
        7nzNdtK1LvCeiQ5/+9WUSz4VcmykzFxmiFW3Qu+1rGtghhxA5zazHFr7LWmOqvVgkufdypl0Ce0
        Cu9cRJWkAkcl4x8oznJTzGQk2
X-Received: by 2002:ad4:5d49:0:b0:444:4dda:9ac1 with SMTP id jk9-20020ad45d49000000b004444dda9ac1mr2488105qvb.108.1649748497393;
        Tue, 12 Apr 2022 00:28:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNqcG2gg+lPrhMhfRjya9yf0TWWGeI+RKPCr5T2GmjCviAtvjwECgL4zSXIfBCgARvZwYSzg==
X-Received: by 2002:ad4:5d49:0:b0:444:4dda:9ac1 with SMTP id jk9-20020ad45d49000000b004444dda9ac1mr2488091qvb.108.1649748497150;
        Tue, 12 Apr 2022 00:28:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-237.dyn.eolo.it. [146.241.96.237])
        by smtp.gmail.com with ESMTPSA id y18-20020ac85f52000000b002ed08a7dc8dsm10612638qta.13.2022.04.12.00.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:28:16 -0700 (PDT)
Message-ID: <3daec73abc2f21809a8057b6a9729a70d2877231.camel@redhat.com>
Subject: Re: [PATCH V2] drivers: nfc: nfcmrvl: fix double free bug in
 nfcmrvl_nci_unregister_dev()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Duoming Zhou <duoming@zju.edu.cn>, krzk@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, akpm@linux-foundation.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        alexander.deucher@amd.com, broonie@kernel.org
Date:   Tue, 12 Apr 2022 09:28:13 +0200
In-Reply-To: <20220410135214.74216-1-duoming@zju.edu.cn>
References: <20220410135214.74216-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, 2022-04-10 at 21:52 +0800, Duoming Zhou wrote:
> There is a potential double bug in nfcmrvl usb driver between
> unregister and resume operation.
> 
> The race that cause that double free bug can be shown as below:
> 
>    (FREE)                   |      (USE)
>                             | nfcmrvl_resume
>                             |  nfcmrvl_submit_bulk_urb
>                             |   nfcmrvl_bulk_complete
>                             |    nfcmrvl_nci_recv_frame
>                             |     nfcmrvl_fw_dnld_recv_frame
>                             |      queue_work
>                             |       fw_dnld_rx_work
>                             |        fw_dnld_over
>                             |         release_firmware
>                             |          kfree(fw); //(1)
> nfcmrvl_disconnect          |
>  nfcmrvl_nci_unregister_dev |
>   nfcmrvl_fw_dnld_abort     |
>    fw_dnld_over             |         ...
>     if (priv->fw_dnld.fw)   |
>     release_firmware        |
>      kfree(fw); //(2)       |
>      ...                    |         priv->fw_dnld.fw = NULL;
> 
> When nfcmrvl usb driver is resuming, we detach the device.
> The release_firmware() will deallocate firmware in position (1),
> but firmware will be deallocated again in position (2), which
> leads to double free.
> 
> This patch reorders nfcmrvl_fw_dnld_deinit() before nfcmrvl_fw_dnld_abort()
> in order to prevent double free bug. Because destroy_workqueue() will
> not return until all work items are finished. The priv->fw_dnld.fw will
> be set to NULL after work items are finished and fw_dnld_over() called by
> nfcmrvl_nci_unregister_dev() will check whether priv->fw_dnld.fw is NULL.
> So the double free bug could be prevented.
> 
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

This looks like a -net candidates, could you please add a suitable
fixes tag?

Thanks!

Paolo

