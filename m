Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FDBC433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 08:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbiCHIJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 03:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244707AbiCHIJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:09:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711A23D481
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:08:30 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id p9so27093792wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w2kpbDHbmA0uZN+CsMThxfqb9nbhJ8u8Feprw4xNVCo=;
        b=H2fvfqR+I6VM2Kk9IJYxRI4A6ijk4Qn7lQFH2W2PR+olehv6klS+VeDxePKtFAVv7S
         8ygNpmOvYIXEw1Jkyy3vf1JJnxERuP+XaHmS1D4zxXtN2EdyDs7ra39Jt13vr/RQNfP8
         fHCRtN0Qudi90mb33HhTUycYmfmsCLq+k+OPt/4IbfQvQfL/Z/f2gIPMksMlUZLRgkD8
         DU4VmMObglStBQIyHpInbQRCEWzwYPwePXiQ0+mePYzxV2j3z475Kofkfj5CBFw6AG0O
         9pvZkuyTRM9guHFOE+Omp3Pxm3rFlyC8wW4M9fzHgQqGa08mdIaUWy/nC7uUgSRFuYZk
         XCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w2kpbDHbmA0uZN+CsMThxfqb9nbhJ8u8Feprw4xNVCo=;
        b=jYWsPCASR7FTbSPtLN0QVuNsQNatOmxQFFP1ZQ8gblxML/qGWTIeADpgsmWUrkNsEC
         s/J2O/xlaPuyS230rhyJpO8o+TKuEwWEsvO9vDQL1P5ImBX1E4hQr4P75tj7ccAWk66O
         VF7Xj8clu597wDl3bwrr8wKu5W1UeeQoku+157bX0TjLP+9NqRTS8syxWP2COF+VRyxV
         RbO2qEA/1VuF53JQoxyvr3ndd/9jp/ERMmkglR9DIbKmwGeOtogsJQmr0esW2vUvsbwa
         qa2WMzLCCNGCXwsIrmQ0O0WBZR3CB3ijVOrw7Gq4epJncOlq/Zcle+JbyVzgDGDi2tTq
         Mpvw==
X-Gm-Message-State: AOAM530BPl2kFIRmlQMHlcjuJdJrB42zUCjUq7TICgR0TONOnLkffo4z
        5iGoFpwKhewMLybxeRFJYv1swQ==
X-Google-Smtp-Source: ABdhPJzxQ/wNPlE0Op8r9v7pQTLfIf/oRM+ZegzSmvEtfz5rbvQrhtQyNtGfUsLEaBrywseYTM9mjA==
X-Received: by 2002:adf:fd50:0:b0:1f0:7a8e:c922 with SMTP id h16-20020adffd50000000b001f07a8ec922mr11353776wrs.166.1646726908942;
        Tue, 08 Mar 2022 00:08:28 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b003899d242c3asm1461077wms.44.2022.03.08.00.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:08:28 -0800 (PST)
Date:   Tue, 8 Mar 2022 08:08:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>, stable@vger.kernel.org,
        syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <YicO+aF4VhaBYNqK@google.com>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <CACGkMEsjmCNQPjxPjXL0WUfbMg8ARnumEp4yjUxqznMKR1nKSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsjmCNQPjxPjXL0WUfbMg8ARnumEp4yjUxqznMKR1nKSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Mar 2022, Jason Wang wrote:

> On Tue, Mar 8, 2022 at 3:18 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > vhost_vsock_handle_tx_kick() already holds the mutex during its call
> > to vhost_get_vq_desc().  All we have to do here is take the same lock
> > during virtqueue clean-up and we mitigate the reported issues.
> >
> > Also WARN() as a precautionary measure.  The purpose of this is to
> > capture possible future race conditions which may pop up over time.
> >
> > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> >
> > Cc: <stable@vger.kernel.org>
> > Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/vhost/vhost.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 59edb5a1ffe28..ef7e371e3e649 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -693,6 +693,15 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> >         int i;
> >
> >         for (i = 0; i < dev->nvqs; ++i) {
> > +               /* No workers should run here by design. However, races have
> > +                * previously occurred where drivers have been unable to flush
> > +                * all work properly prior to clean-up.  Without a successful
> > +                * flush the guest will malfunction, but avoiding host memory
> > +                * corruption in those cases does seem preferable.
> > +                */
> > +               WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
> > +
> 
> I don't get how this can help, the mutex could be grabbed in the
> middle of the above and below line.

The worst that happens in this slim scenario is we miss a warning.
The mutexes below will still function as expected and prevent possible
memory corruption.

> > +               mutex_lock(&dev->vqs[i]->mutex);
> >                 if (dev->vqs[i]->error_ctx)
> >                         eventfd_ctx_put(dev->vqs[i]->error_ctx);
> >                 if (dev->vqs[i]->kick)
> > @@ -700,6 +709,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> >                 if (dev->vqs[i]->call_ctx.ctx)
> >                         eventfd_ctx_put(dev->vqs[i]->call_ctx.ctx);
> >                 vhost_vq_reset(dev, dev->vqs[i]);
> > +               mutex_unlock(&dev->vqs[i]->mutex);
> >         }
> 
> I'm not sure it's correct to assume some behaviour of a buggy device.
> For the device mutex, we use that to protect more than just err/call
> and vq.

When I authored this, I did so as *the* fix.  However, since the cause
of today's crash has now been patched, this has become a belt and
braces solution.  Michael's addition of the WARN() also has the
benefit of providing us with an early warning system for future
breakages.  Personally, I think it's kinda neat.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
