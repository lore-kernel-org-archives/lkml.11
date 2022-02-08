Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88CCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 09:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352801AbiBHJCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 04:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiBHJCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:02:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A297EC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:02:48 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h6so10696522wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=n56/xrs0hxqVo6GWZnZfSDoECfRT5lppeZnAG5F+a1s=;
        b=qwFnLzTKi1NrFw2maL+H23WzNX3hCDYLFGXpOmbb9C72/aL4Vhje0ATD3SuwK7qE4o
         OMRXCZHC+KH3MIJiQZzShe+/HY+gWlP2zipO8ZsWEtvNwUPYblUchZCiPKVKMWR5mriN
         IXk3E57qaqocs7fnciZK84zaq3exz4edSi6KYuRtVnHXmFnlYBNpK4TbND2z0qEGMV2U
         1RX4nZd5OEOEFoXx7VpV0QfdLxHxg3waJsAG1OKncxsKPMs/oQYmjtkWv0y/NM2uBq86
         cyvjrpCQy+Ic19itZZEfs3DB5BK2Z3P3863z9GHY6B7zUNfzyz7KY8w7Q8SjfUt/5/Fe
         oKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=n56/xrs0hxqVo6GWZnZfSDoECfRT5lppeZnAG5F+a1s=;
        b=6/6CT7DxOdlFBGkEW5T5CkWk3XrOBRNZdVXm9uBF2qsr6pB798vzs45Uve9zVTo5rL
         jSZMupQLi2KKseBJqqBZyXexevG3d6rmIDzpMyj7PiologQ8sgter6CX0ezxMI9pIf+9
         r6/m9m+uc+RTMJGjigWwmb5uF9Fja2zQ9HzObOFA2ocnMeCgglQLrH3yUaVHCUhhpd2Q
         36lvoOK1rpzvAJQXDqoZKKoj+vS5sDkUhw2nj8Zd3Wx65q6owyOLiHKoko1YPsAlba7b
         cHwSXnhC0EcV02h7TK9UnJFcit3SjSr9Lrso/fCBqtfqXfd0EezRPsov2Kz6HLJ0Fl+/
         n66g==
X-Gm-Message-State: AOAM532v1i1CsBRaYHSDOU7o/LwMh9xNeUi+xTuCvI6fnUerCFYClnIu
        ID2sig+F2/i4iqSs0VZ/pTXJzw==
X-Google-Smtp-Source: ABdhPJwHEfvaeXH5AKLjxqQv5p5c9KMMC6f5d8Nv1AxuhlRU5I2VVi4/kVGTCYKWqNEr6kFOycPc0Q==
X-Received: by 2002:a05:6000:108a:: with SMTP id y10mr2602424wrw.464.1644310967268;
        Tue, 08 Feb 2022 01:02:47 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id y3sm13294390wry.109.2022.02.08.01.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 01:02:46 -0800 (PST)
Date:   Tue, 8 Feb 2022 09:02:44 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: db8500-prcmu: remove dead code for a non-existing
 config
Message-ID: <YgIxtOX1UhxYWUMw@google.com>
References: <20211227064839.21405-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211227064839.21405-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021, Lukas Bulwahn wrote:

> The config DBX500_PRCMU_QOS_POWER was never introduced in the kernel
> repository. So, the ifdef in  ./include/linux/mfd/dbx500-prcmu.h was never
> effective.
> 
> Remove these dead function prototypes.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  include/linux/mfd/dbx500-prcmu.h | 18 ------------------
>  1 file changed, 18 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
