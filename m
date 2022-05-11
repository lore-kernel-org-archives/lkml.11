Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB5EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 07:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242598AbiEKHIF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 03:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbiEKHID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:08:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8FBA3087
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:07:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g23so1328281edy.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yp55JvrZnoapZhhPg9nglUGsDWim50kPROdVVnou5Nw=;
        b=Tbvi5ltsARlvIdW+yMDCQBzBIclvAZymsXsV9F1mkVq/BGVV8KVRlVGR6iMnl9HDR+
         3AKJz2+/ZQxFAD9NoQksKZ+KbajOTvsmF7dhsfCekiiBg+WWkAZFgG6ZoFT+rfNm9BMv
         jQrOD8jcc8q0YMiBHGx8DDTqA6mFaBTeMhQLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yp55JvrZnoapZhhPg9nglUGsDWim50kPROdVVnou5Nw=;
        b=g1/Xn2CZO7nVaUlSXD1lnMgrsjnknvzPvrJRvrgTKXlS8j4NQpdZ2vxgobGNtV/eIr
         AcCkRF40dXu0wGK4OnpTu/NrigHKhGd7M/3fVbc2jsFUK1+LvqXAexEaqMUUpOVy+810
         4af7G9l6L2T11+vnJ9htqnYIOdcpWBbStah+42j0TC2NPv5dk9PLbzI94xpGglmo5CFh
         knsH5E0CFLZ45hMOxpdErgNyCT6v4hIXYCiz8QlKA733JHuQ3GvELplPZ8ReG184+L3/
         Gg0qkBWf4NDMfEsUp9Izm/9Gc3PmEXBG+yxvjwnFH4OZnH6mlPK5SX1vu8K6I7Hhi1ct
         8+XQ==
X-Gm-Message-State: AOAM531rl0Qj+Ksx/hCJxZuQNXIEpdqiFxH/aXbevDtvaBz1PRLQ1VKO
        IEFEEbBWSgqeoXMw8BrEkS7MZjrPGpakWRJttmu/PU/IMcd2DQ==
X-Google-Smtp-Source: ABdhPJxes41Q7Oqs4oy9VMmXMdOFiEdoAK5Ep3Ngad2GkTjCm6BDzEGO5c+BibRshNVGl0pSqC5e8tq6q6OWavesbug=
X-Received: by 2002:a05:6402:42c4:b0:426:a7a8:348f with SMTP id
 i4-20020a05640242c400b00426a7a8348fmr27535912edc.341.1652252874751; Wed, 11
 May 2022 00:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220511013057.245827-1-dlunev@chromium.org>
In-Reply-To: <20220511013057.245827-1-dlunev@chromium.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 May 2022 09:07:43 +0200
Message-ID: <CAJfpegsmyY+D4kK3ov51FLGA=RkyGDKMcYiMo2zBqYuFNs78JQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Prevent re-use of FUSE superblock after force unmount
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 at 03:31, Daniil Lunev <dlunev@chromium.org> wrote:
>
> Force unmount of fuse severes the connection between FUSE driver and its
> userspace counterpart.

Why is forced umount being used in the first place?

Thanks,
Miklos
