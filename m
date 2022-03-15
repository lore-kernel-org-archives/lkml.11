Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A546DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 12:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348404AbiCOMot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 08:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbiCOMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:44:46 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9904133EBB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:43:34 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id eq14so14852686qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fEAT5UUsmyhaWxfcdGvh7mL5N8nTzlfAjcT9ivAGrCk=;
        b=cJ3yz86PEJDMILIQDbCRMD2eU82iXa2ZdXQiRq/hGWWqGtCRC3levbgE1ET08LU9JZ
         Idn5sFu8lxnTQL1hHkWMqNUUNohvVuk33T7Er5pIDgobs0u9fwZ51Y0BYG7sEic/uHli
         gBxt9aBWt25EJoNh2wcv5sbrlTOfvSGOLDznrsFb6S7YuIIlfaB09htbwydgfWEHkhFW
         lzEDYnuMGPHCPfylp0nNT5oN+UIU6NITjEKoJO9NerR3bfgpLmlcU6VgyLOPtgM//zqd
         ZDwG53dsSK1qMWwtZCaS2kCNFkzEoQ2FGVH7My+q7d1fBMrkGuaEZLIU/AJf3uA/zUeo
         eY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fEAT5UUsmyhaWxfcdGvh7mL5N8nTzlfAjcT9ivAGrCk=;
        b=ICPtGhUyB2Se8AGdpmsDFKOJ4rMtV/1nOaWDAuXa4IfLlTCWT1qJO2wWTWInXv85KD
         OsDPKmkfPFN3mE1vxqfAgaWO6DOEf6bRf4Q+W0GF+OsnQ3WZ6GAiLrF8/Ma7jvdBVirn
         e8tISA2YcXrcZQEVEuvYjUA3HvLNODtZSVh+wM6f9BHPj9X3MTkBu3CxVpg4WfAzBI44
         0kL7n0ViLfUjpq4X8GOr/5NBa56hKd8JYKPLgCRMEaHVoODSfWLvZiS7Lp57Udaf5Tpp
         J6OSLp0tH0wEsmTqcF6V3Gs5+Kd0DO8L+8nJbf/V51IlUatkhXtXAIbSFgZCEaL2e9j/
         SiLA==
X-Gm-Message-State: AOAM5328gr5cMOIHrYM7Ow83D0BMOoUabLdu/TeZR4Sz7WP30rurpI8p
        bjkh6ZHwPUOCUbkUmzyhtZFk3YdQst2wBnGd9yk=
X-Google-Smtp-Source: ABdhPJyoBonLxpVxdTKXm42VxIsdx96swV25W1RhjgHw2hK2gkTM/mwRVMnfK/H+pC9Fm5nWO7+Bak6+7qLijWaZH/I=
X-Received: by 2002:a05:6214:262a:b0:439:2d7c:a4fb with SMTP id
 gv10-20020a056214262a00b004392d7ca4fbmr18312638qvb.121.1647348213749; Tue, 15
 Mar 2022 05:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com> <20220314224253.236359-8-dmitry.osipenko@collabora.com>
In-Reply-To: <20220314224253.236359-8-dmitry.osipenko@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 15 Mar 2022 12:43:22 +0000
Message-ID: <CACvgo52-pd-g=ZnR=m0T7W2yQ4i7_Q6gWy22=vm-fX+eA-YwQg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] drm/virtio: Support memory shrinking
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings everyone,

Food for thought: Would it make sense to have the madvise ioctl as
generic DRM one?
Looking around - i915, msm & panfrost already have one and the virtio
implementation [below] seems as generic as it gets.

On Mon, 14 Mar 2022 at 22:44, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:

> +#define VIRTGPU_MADV_WILLNEED 0
> +#define VIRTGPU_MADV_DONTNEED 1
> +struct drm_virtgpu_madvise {
> +       __u32 bo_handle;
> +       __u32 retained; /* out, non-zero if BO can be used */
> +       __u32 madv;
> +       __u32 pad;

This seems to be based on panfrost/msm yet names (bo_handle vs
handle), layout and documentation varies.
Why is that - copy/paste is cheap :-P

HTH

-Emil
