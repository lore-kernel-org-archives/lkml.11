Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25731ECAAD2
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Aug 2022 13:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiH1N7j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Aug 2022 09:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiH1N7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 09:59:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7C632D8A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 06:59:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lx1so11017968ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/oXOPWWho/MuSiQT7Uwd2bmMqCA70Z1crzuATK2DbsA=;
        b=ouo/IBCxMkmbXhwGxeHVl2gsqINhm601cdsvEhPUGY6qWNNa52fNuRXDq8RFHGHrtk
         e29f7Wo4BwC3C0kpvd5hmfCqzJRDErIiLGmGH9RBbm0cLLnBU/cf1nJ3apT6RNxcc0bv
         qWCoXDFj71b2dyjNsQ4WyvYku7cLHM0JCtUpE/h5OF+BGix6eAoNnDnrHVR7zpCdWo3c
         lsLgimCckysaqCvBoWH1fI+rAhGXcaeYvQ9xeBJSgMlY6jkohwh/G7q3lrlVgjfon4o6
         aV8zfODxzcnOARHLphRuuIu70iXKYr9D+C0AoHsy3OK7yQmrXrS0ahtYOl17G0+I5S8I
         m26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/oXOPWWho/MuSiQT7Uwd2bmMqCA70Z1crzuATK2DbsA=;
        b=pQqHMdZXWGgyh9j4R9XEJBT3h26XW+vEks8BbUpCokqtNuPRXhWB7S/AdUUvCUr3FY
         hqx0DN3YAgm7IIT21W5DJA6OiESdERPON0dIacDqMqHBnJLGu3UPduVONLIsDoPXeDO/
         PLSFwIxK6e95i1Okh34bcyNLFqOEV8SWPPmalHpP962MX6PrFwTI3lkdDz07I91PhGIR
         IcEUtJPbqa+pTcStfEfLbXOuvL2iBDHWqgnsGUtPzgI0C5uv9fo4/AsTIJ0FmxPR4W00
         QnrBDnCBB2a3ltDFuoeVBBjOT5Vcgpdm6zXdscvwf9HxXeLZfUvESqOQrzWfSL4JhXgL
         COYw==
X-Gm-Message-State: ACgBeo3meZ5/pby0wSVfYPK699WBtWdIACnH5FGyGVyCsq2prL/J5tCk
        Z+M+cG55U8oYSWq+4/vfytv+qCfphbpwXanQiYl9A9v2QnA=
X-Google-Smtp-Source: AA6agR7YZfNeHP3K48zotp2yhXazjSBcEAh22Z5nB3LJfkHa3QjLVDhFde/F31kKRKK2Mi9O4fOkD40TxWD1/+aDsQU=
X-Received: by 2002:a17:907:7254:b0:731:61c6:ecf9 with SMTP id
 ds20-20020a170907725400b0073161c6ecf9mr10982053ejc.101.1661695175478; Sun, 28
 Aug 2022 06:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220822041025.3221406-1-weiyongjun1@huawei.com>
In-Reply-To: <20220822041025.3221406-1-weiyongjun1@huawei.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 28 Aug 2022 15:59:24 +0200
Message-ID: <CAMRc=MdM7JMVBRPHUhmYURcu7D9dpBH6d+=9yCiTNtwpTxHpNQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: mockup: remove gpio debugfs when remove device
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 5:52 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> GPIO mockup debugfs is created in gpio_mockup_probe() but
> forgot to remove when remove device. This patch add a devm
> managed callback for removing them.
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> v1 -> v2: return from devm_add_xx directly as Bartosz's suggestion

Applied, thanks!

Bart
