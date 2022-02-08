Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D10FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 17:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383493AbiBHRQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 12:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiBHRQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:16:25 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C006C06157A;
        Tue,  8 Feb 2022 09:16:24 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id k13so34594600lfg.9;
        Tue, 08 Feb 2022 09:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lesage-us.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c7EIjwz0EJtS9fZYIZ7QG6LhyyX87HWuqqCKQipcuJk=;
        b=nX8fMP+QSuz8NppZNnGyjT8UFiQ83EdCAnIDGld0ZN68LYe/M86JPcWGpAzIVx5pcJ
         /LDutXnYMA/YNNyS9xfXGRZkkLCLDQw+OfWEOm1OggiyFTDP27NajJRNJpMv7EKqJ0Og
         ojeXZ7oNw2QjZuhWQkZQ4zduyyhZSvNUQ3xAf7G7+sF4It/wDJ+jw62NPPpdKYf9NZWf
         qV+hboRJGCC7OwiSgD059tBe8mezYCb15xBsFPPqy9YyEvFM/mBzagdaSBdq7Gycgz4d
         Eys4sWd3cb9YwstCGEA3C1FBoINV8zMUGPa10Ha7DbwUBUjysYPLgzAXvOHCGMG1xfp7
         axrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7EIjwz0EJtS9fZYIZ7QG6LhyyX87HWuqqCKQipcuJk=;
        b=DwwO2M8biBRFRyHBFY/HJoOcrt8BEXnBFdslfPYR6omSGj+QDFoh29WBPUe8qlV5ur
         PzQTX6wOZ6/3rLwCGu2Gjdh9/mCA+eGPQ0/fu7SkhRgEZKPLcTmw3pV/fJLQuoLMRbNO
         lUdj/cSDWRUW0DpsF7mv+Xd2Dkv0V5CZbGhzurfcZrFD0+beQ1M02uDjaK1B831q60Z1
         0RPSIdVqXd14jvvrIa8s02ySZyCA+fWa2k7f33Nr+t3yo9UgRWtePyXugjbqDt0u63jw
         lowrRC0XaOP/9SP0DGw228Mds57dXow1kaM/sHqTtaP4bsP2b7Uun/nivdhEAvYMV40H
         JjeQ==
X-Gm-Message-State: AOAM533PPota2kBtPx0wrq0uzcCg0yix8ay+Ylwdp6/UNnf5tS2+Uc6K
        dfPtvy3PYQCK4MvYnPYs0T2yKeJcUEqnA+oFL4K07ezk/Jw=
X-Google-Smtp-Source: ABdhPJygonmJVziocQDGDzhlthbj7Xh4jyb7I8CuY4PKFqruTVl8vhXXcMHsLHTrWeBEpfbUuGwJB8E/EfLZkGNt3z0=
X-Received: by 2002:a19:8c19:: with SMTP id o25mr3493486lfd.300.1644340582791;
 Tue, 08 Feb 2022 09:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20220207014418.GA28724@kernel.org>
In-Reply-To: <20220207014418.GA28724@kernel.org>
From:   Garrett LeSage <garrett@lesage.us>
Date:   Tue, 8 Feb 2022 18:16:10 +0100
Message-ID: <CAFfNkxV=DmRJL1Oqm3w9YzBYcNLSAG3Ss8pih9ZVwh_E-Fbw+Q@mail.gmail.com>
Subject: Re: [PATCH] docs: add SVG version of Linux logo
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Garrett, it would be great if you could confirm here that you
> are OK with the note in `COPYING-logo`. In particular, in your
> repository, you license the logo as public domain, though here
> I followed the existing licence which requires giving credit.
> Please see below.

I confirm I'm happy with the license and note included in the patch
and you definitely have my permission to distribute the Tux SVG.

Thanks!
Garrett LeSage
