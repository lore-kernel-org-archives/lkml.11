Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943DBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jul 2022 09:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiGRJ12 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 05:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiGRJ11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:27:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0169E19C15
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:27:26 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l23so20122980ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+icv+IJ1TJ8/3xu2M4sP7/7AeCsZ4gFWLPwS5u9SNFg=;
        b=agRDU6yWNC6T3uQoKsXpznz1Nlk4E3NowXCVh5Op296iiyVx9blby60QuJ42Nh8nGJ
         23rlSGHxc2W2PI/uZQGe4hex0YLlie2DBijssE75xA67XCP59AOl0IWMf0JJse8KtbAn
         yjrwOUftMzLC4TAXDzV1JUNGEvxK7pZPPZp5F4UIO/MA2N6ugLyx+gdb1bbDCDVvOz9O
         n2FaZm4mUbuet201w1dpS00dzTpJLSqh6BbIngIAyrowzsCKOsU+pF2XucMpHq7wf9p0
         nVXMwkcMN7uzxLKEB34PGkDsRJX7uMnhIR4HBDUBzqgt4rswVc55NvgQGLF+0CY8I/9m
         yEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+icv+IJ1TJ8/3xu2M4sP7/7AeCsZ4gFWLPwS5u9SNFg=;
        b=UJ1jd+qM6lveTAN2durVQ2Iy1BeLv8JLWsB46SQm0/vMoKc2l/URKER8kWNBmMHBdY
         2jfHVcmBGjHWcnaCez/Ysf6afx6I0pkiT8/pNChgopBbxI4pRUR0C0VP8V9a7RkmycrQ
         RGWc5qbSAc5DgGW6MLhO2ZwfgGrF5brQswu5LoaizlQLyF+udERbJdkp+7rJlLf4nInm
         pXxRE3jsG+yBZLZYY+ushgVLdFuaJ9eRcx2Lr2pJ/ti0a4KF5VeVvK40Ycfk4sfr7vRe
         +q6ENney3AOEmHWfHhopKJVEtyNzeLMZeCoQBQU76NAGzhH9Kg4wCflSv0tAYJNJ5s/v
         8egg==
X-Gm-Message-State: AJIora9duD0x8B/NW/XY7DdAZh1gNZ9qZ1qZDgpik/u1jdouxLosu6Te
        qGJ6w5U6YR39mGDBSjWQ0OCibARgvp5HTgS2gOljsg==
X-Google-Smtp-Source: AGRyM1v9fKqHGAElZYf1oxl9ZazBcWXcPQYo3vM7TuEExHTjtodpQSuuSmWiB9RLuNbqmAQ/SAwEJa2Rnxa/BDvJ3cY=
X-Received: by 2002:a17:907:9612:b0:72e:56bd:2b9a with SMTP id
 gb18-20020a170907961200b0072e56bd2b9amr21685288ejc.526.1658136444582; Mon, 18
 Jul 2022 02:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220713013721.68879-1-warthog618@gmail.com> <20220713013721.68879-2-warthog618@gmail.com>
In-Reply-To: <20220713013721.68879-2-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:27:13 +0200
Message-ID: <CACRpkdaO9VWH4nsxseY9==wUVb6M+q+AVKEd951GJ_KGV_FJVA@mail.gmail.com>
Subject: Re: [PATCH 1/6] gpiolib: cdev: simplify linereq_free
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, dipenp@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 3:37 AM Kent Gibson <warthog618@gmail.com> wrote:

> The edge detector is only ever started after the line desc has been
> determined, so move edge_detector_stop() inside the line desc check,
> and merge the two checked regions into one.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
