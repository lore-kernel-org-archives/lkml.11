Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B4DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 22:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiEWWvw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 18:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiEWWvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:51:50 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F076764D05
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:51:48 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id y20so13105524qvx.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3vcI1skfMKoqTzgW6PwoPYdHQpeyuuPuHAsg8j4YyY0=;
        b=SK9Ai50QmK6g6drZEH6TCZVx1ybdkR30gnwYdm8OX2MZCjPFMpadH8tfGN3bx+9Td/
         JV4EOdx30Sjs+Wg+3M4XzuL+MmICDQvxsjNn2upQIy/Cr3xj68l6ozh5NDZaEZ1s1MhM
         TP2EZ2UeFyTtIUDrq0OkG13phXlQ3YEFq2qdYhlMDss/hhT0i37Q23MzydGmfgrwxVVD
         1Ynl64Hw5+VjP6MxxOe8LC+afzQGyF94jDraJmba/Q9zz0VC4aa7Y7boG0hwCN5gTW2x
         eABDT1He8d4kgRdJTTSaINbiF16ijulZOPa6HhTqFr7VSpwqjfwhDTQs328T9QCkXIj2
         8nrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vcI1skfMKoqTzgW6PwoPYdHQpeyuuPuHAsg8j4YyY0=;
        b=G/vSwEGUPvSaZhYJqEmvwhoyvVAJq1qz+1USsjaYE1lenTZHFoXbrlCa6bM2vCbNDH
         gfsAncltCI+LyKPySO/Fr+R6Y9xZ1dk9S3I1efglWW3xVSfxdxTZ3sEODSk6LuPCBc3t
         ZcrnVBz1miXGHgpPFFM5KrPdtGDc4J6NjFMHiJl2j0Is1StlO3P9JE5uCpJdpUMErEEh
         uECkuruLaRsM1+J7d+hVpmtDmiKoO42g0xbqTomz+eHaOrtpGJi464ab1LnHhXb+qo43
         krNenMqvmWyhPX6SHgLF052zN2C8r4hWTc2YjbDtgJSeRaxP5tnSRgeeknzROFfHN0bT
         IRgw==
X-Gm-Message-State: AOAM532dCRd43gW1hL2v8fW62UgA8SAIDLIMgl/8o9pG1v9NvrTekBLO
        BQ7wIIwoj8QywWKlAx3XhxbE1tIT9A33h5qDMoREYw==
X-Google-Smtp-Source: ABdhPJwMUeQdsntLd2uLatzH66lXWsSEabtV+kiZYKsXgWX2xbdL3qvvkkPq6NF2azOSQPNRYAvN0l9Dt1B7OzOioVM=
X-Received: by 2002:ad4:5f4e:0:b0:462:3d31:6faf with SMTP id
 p14-20020ad45f4e000000b004623d316fafmr5677472qvg.119.1653346308200; Mon, 23
 May 2022 15:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220523213837.1016542-1-marijn.suijten@somainline.org> <20220523213837.1016542-9-marijn.suijten@somainline.org>
In-Reply-To: <20220523213837.1016542-9-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 24 May 2022 01:51:37 +0300
Message-ID: <CAA8EJpoPv_J=hpc9ETjngyAxxqJYvSFtJUgu3U3r6n8JNMuJWQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] drm/msm/dsi_phy_10nm: Replace parent names with
 clk_hw pointers
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2022 at 00:38, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> parent_hw pointers are easier to manage and cheaper to use than
> repeatedly formatting the parent name and subsequently leaving the clk
> framework to perform lookups based on that name.
>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c | 92 ++++++++++------------
>  1 file changed, 40 insertions(+), 52 deletions(-)
>

-- 
With best wishes
Dmitry
