Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048FAC433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 14:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389416AbiDUOjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 10:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353593AbiDUOjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:39:46 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDC218E3A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:36:56 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id f17so9077738ybj.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vn15wv+FqPqikIVHkmLySvij1W69RbvcRNe/3SQcLlk=;
        b=dVUomZ7QD2D7SvmPYWYjf3spdP6+Vmk8hg17aDWRGQ/leX+NZ5UrPfvqJqDvCsRy+o
         kMOcMwEdHzYPlPCfZIWpblYN/R2i0GTWru2bUPQoMAU8p9bZjv6KCSnDRV/eEpUyn/DS
         REvHnB0guf0oeudsvyIPFOBoIZ9/cKUCw6kPSWFGsujjotH8Hp37dN0Thhe/IZvE+QBN
         4F1fOK4be7rcdLQvV/px/frnB6xFMu4dUK8LnMNU160tCdrw5oI5E7DcblNRy/800Yy3
         vZzh9SLyRoaGsM3nPNxDGfJx0YS1y6xjO473q+0cO+9FdJSPjGJpq5So0PdoUO+UXfkH
         iocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vn15wv+FqPqikIVHkmLySvij1W69RbvcRNe/3SQcLlk=;
        b=btMQisBvnVwY44Mf1G1jD2x/1jDFuRVenj7URnQ5Qcuhs4ArOMGDcmZqeh9TSeBESh
         GM4AwAFw1qOqrNdBl1JMQVFgqIsnpTrZTNx3ce6PEFqMEolj2A+h5mRb77mBGOxqZVxr
         daCpIMSZ/wJ9By3KI8fIC2zKh8q9YWlj+5PSCvlJrezm3snM99gLcmXOUHkIqmvrT0Hw
         jZ4GQoxbar6tw2P+uQJm3UE0GaqrsJOqn4h0SFZvQPQkQEzQiTuAAOoLiLpUgHexPLRa
         4cwkH8e0CShwVJiw3GQ3EmJU6M+cwQKTm46OCh5uQFb1a7Yh/I9MviqtXg/DVLv9fRbR
         j1Mw==
X-Gm-Message-State: AOAM532sAjeI+4pLzhUGfvLH7SdXdb1/+ScqOu8Htf9b/LiJURsTuvYz
        pSwGvAjLJ3XlLr1MJXrLJnn00qiTe0oKudDUiyJzcw==
X-Google-Smtp-Source: ABdhPJxhzs09Xvjg3TGzcfPz+UMZgX0YyefQ6OzBEn5stnWdR40bXs+igy7UZFMYf6aIIf527lpQpUVYMl+fa0K+B3U=
X-Received: by 2002:a25:4e82:0:b0:633:68d7:b864 with SMTP id
 c124-20020a254e82000000b0063368d7b864mr26071974ybb.514.1650551816035; Thu, 21
 Apr 2022 07:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220418020238.2556989-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220418020238.2556989-1-lv.ruyi@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Apr 2022 16:36:45 +0200
Message-ID: <CACRpkdayAjF9xvYX-KC1Og=PUT8quO0sKptS6pK4HMsxtqFzAw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Make use of the helper function devm_platform_ioremap_resource()
To:     cgel.zte@gmail.com
Cc:     lakshmi.sowjanya.d@intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 4:02 AM <cgel.zte@gmail.com> wrote:

> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> Use the devm_platform_ioremap_resource() helper instead of calling
> platform_get_resource() and devm_ioremap_resource() separately.Make the
> code simpler without functional changes.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Patch applied!

Yours,
Linus Walleij
