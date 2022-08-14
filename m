Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F323C25B0F
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Aug 2022 07:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240289AbiHNHrr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Aug 2022 03:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbiHNHrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 03:47:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE321205CA;
        Sun, 14 Aug 2022 00:47:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id w19so8739872ejc.7;
        Sun, 14 Aug 2022 00:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Hnh4O8lBATWYE9MckUrwDYzVE7Ezy3HP7Kymm/nWvtM=;
        b=Fp6/0M1coVCo0dHzpCuZtyoy5EV5+zwP2A3veaF0rQ1xP89YJfwisOeMA2J5yIhK/P
         Sl1Esknrec0buoonCzK3KNI3D9AFa80+3/V56EmdDGPV6bt95CY4fuzVgdRB/n4mFsDJ
         H+sqK4k79aAUiJXbeAcZmJFsHuXUvti/gdecNZiYucgS9AnZc4a32VOjo2utgb3yPspa
         sLX+8WuyIAZEBJh4ttLUfX3BhZtYlStNkF7oTmCpZLbBy1O78vdD5A29PXz25/W7BsrC
         xdlcwfOsU/bSWaULv3dmii+g2nOMrwi/WrXMN62BqR+dHyzKaM1Fqh3Y2FiocbODd8ag
         t51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Hnh4O8lBATWYE9MckUrwDYzVE7Ezy3HP7Kymm/nWvtM=;
        b=xpRgMFuDL2z/p3z4niNV7jyctkkQ2V0torN2mZaMNmsGZGyvJvKBPOIU60+3JA93SG
         LmAr1Fq0IYqRqdVIpIXzi+YovXe+aufoMEIhnM0pIf7h8tYCMQHeQ3OCJVQy5s6TFlUi
         YUZioQQdALaLFVvfjG8aV9qgtl5DRdMRz4oNDYd6krQxGBK90n5LhJyRnPWpdsTa4MJ7
         Av5XTu7ZmzJOH/ZrY+F1lXmxgmfImUq7btdRAxqpuKcU9LJX2gjVEcJ4yHsySUhjQjpE
         PW4ZRxtcbnAXrxFWYGiGbAwIiQzogeKcWi1GSxmcgQcMh/r2AjY/pEdQ4UO/HffLCwzO
         JmpQ==
X-Gm-Message-State: ACgBeo1Ord+95mAmol3B18/8/9xMQkhTfnIfoIjVdbsQo1ynvi5agXqC
        NUj/nRiEuEysehLJcL1Ssko=
X-Google-Smtp-Source: AA6agR6vANf1pbhVeeVmygcGCmaP0DXMRLm1Z7g9ey+MR1EXQB5U4oGHawZ6EGSAh+bQJawKfVONCg==
X-Received: by 2002:a17:906:fc6:b0:72f:d080:416 with SMTP id c6-20020a1709060fc600b0072fd0800416mr7304325ejk.1.1660463263575;
        Sun, 14 Aug 2022 00:47:43 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906078d00b0072af0b036f3sm2666813ejc.41.2022.08.14.00.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 00:47:43 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi-ng: d1: Limit PLL rates to stable ranges
Date:   Sun, 14 Aug 2022 09:47:42 +0200
Message-ID: <2839208.e9J7NaK4W3@jernej-laptop>
In-Reply-To: <20220812080050.59850-1-samuel@sholland.org>
References: <20220812080050.59850-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 12. avgust 2022 ob 10:00:49 CEST je Samuel Holland napisal(a):
> Set the min/max rates for audio and video PLLs to keep them from going
> outside their documented stable ranges. Use the most restrictive of the
> "stable" and "actual" frequencies listed in the manual.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


