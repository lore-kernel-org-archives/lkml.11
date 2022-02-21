Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44FEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 04:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343761AbiBUEYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 23:24:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBUEYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:24:34 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A3C37AAC
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:24:11 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2d646fffcc2so124935417b3.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/DnNowH3r+bx2ltFVLOEYXPzes7apZHo8qc6tZmack=;
        b=fuogfxbwZ/6ejxZgnJLHJjEabeg/rv6U1j6/+NVdkHF2h6fOz/7kaiooTto0bFrWvQ
         C49ySfCJP0IPkPbSYdUy/0BOxppwbhbASyu3EX9qZHmuqU2vm4oLabP2+768NhJcGRb0
         MIfk8uu7JooxnViFnBvk4Drqt9uhUnO/mZ04Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/DnNowH3r+bx2ltFVLOEYXPzes7apZHo8qc6tZmack=;
        b=W8aWpHps2TDqwio9JuqCBpu4pUX4UQlunaaUJFn8LzeY6mylWsWahLdz1/WiP4izYY
         EwjofsDunW1N0dpuzUYwh3qvCz+mVgOnIXmdJ6WqF6hLr42VIPnY+MXZiC9IYvXgtqlL
         rdU8/uX7hsg/7dv48zzMwWZ9XXDuLxGhdeQozCLpjTo7kjjkmjobMy0ldyvV4aT797uj
         oNjVki80q770zdbCusHYLHABqq7JYdR6lEuhpDGyZJ6ye15ShhkZdfh4EhheXiyRLLcs
         0VtxCcJTUo1UeKu7pP1Rana8cIAZx5P/yBcs/XM8WrqDOnorgdj3V0JziRn2W56npe6a
         oT0g==
X-Gm-Message-State: AOAM533OEFhdtAokWDIITwuu8H0EcALWFpCVSNags44q24/X4O4EuAYx
        7+RbO1xVTqJp4iTyA86bTBbBmGD+9YhdGzqNd8fGrFjCUIo=
X-Google-Smtp-Source: ABdhPJytZN/PK4m+XtCToX84qZfVUy9yfbPQVMa2AclViI286QsZGxFQJJ3+GhCYLXLRPIrAMIvQ+wG2ySoMQRrxFwg=
X-Received: by 2002:a81:b044:0:b0:2d6:bd1f:5d8b with SMTP id
 x4-20020a81b044000000b002d6bd1f5d8bmr12913803ywk.27.1645417450796; Sun, 20
 Feb 2022 20:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20220210141931.291712-1-angelogioacchino.delregno@collabora.com> <20220210141931.291712-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220210141931.291712-2-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 21 Feb 2022 12:23:59 +0800
Message-ID: <CAGXv+5HDcKYcSfdVgVBcZm1uWzVuoUr9AZDQbugYxeRAGAxNtw@mail.gmail.com>
Subject: Re: [PATCH 1/5] pinctrl: mediatek: paris: Unify probe function by
 using OF match data
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sean.wang@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:20 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> All of the SoCs using Paris pinctrl are defining a custom probe
> function that is simply calling mtk_paris_pinctrl_probe() passing
> a pointer to the SoC specific mtk_pin_soc structure and nothing else.
>
> Simplify the probe mechanism across all pinctrl drivers that are
> using pinctrl-paris by passing the specific mtk_pin_soc as match
> data and using function mtk_paris_pinctrl_probe as a common probe
> function for all of them.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
