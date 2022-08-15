Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01E0C25B0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 16:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiHOQ6c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 12:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiHOQ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:58:04 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23500275F7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:58:04 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id e28so5907689qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=i6uaaQHrtDde1zPYWlsMw0JoUFKTi+msuNGDooaVb8c=;
        b=RUZS30eMJYJpSnZQzHULvpuFrOzQagmG4WR2Pzq/x81ToGzIabgNsvOiAK+G6KlkYu
         QjdOoQYM3iyJzc1smbg9Y7EM4BfFlG8vUwl3RebykKX963GF/WXTAhjPP/dXib8wJdNa
         BpskaBFwyuOEXTBx8Bb5q4pi1a3tv5bXvM1MRG7qt9+EJfD7Ql8wtLs0F4LXtI33/mAf
         X9EhbSG2wsglz7wjIZ8c9YbZVi6mNeFcKRYoEd3WfeQ1Ug2EjjOCyDxighjg+owKLKdo
         coRXEsOj/CvOggLrzSxZEfhfeDs6wRdFYpXpPp5Hazw78anWjLfWdOJTEw0+QVwUf+2y
         ki2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=i6uaaQHrtDde1zPYWlsMw0JoUFKTi+msuNGDooaVb8c=;
        b=bC/JcdpXCT5rlRAKE2RN07I1DeyzAq6ZY8McB2PfZvNjEigeRIRM+2PwwVWvsrDiVl
         0E6vA0Cg7Nl/k+u72BBvtzMDohHp07D8skPDTPQCcXT59jjIBC40eETWwNQmG3HV1TM3
         K6kwiDarvWAMSHQTecgs1L6GJJVjjINdcfF8EikzLXdhut50MvUmLEsR0Bsc8HNoz1c8
         OZCcOWDbjFwhd48KiLiBCZ3ZfpooO8exseorU0qzl8rcUkEiqrxLSnD62NsCS2QpbzBs
         6dXgLWHAal8IeUh/wuyhwaJ8/YRfEBlaJcluUkgIpyVwSA1ngORTxN33r0Vb4oag/WB5
         fDtA==
X-Gm-Message-State: ACgBeo3SFJtM7pcPu8ZScwGi//tHUO3KR1eCNbQhFWn1yaUjktUr3tis
        nsapKpRbBEKLOFKItYAMmeE=
X-Google-Smtp-Source: AA6agR4sUWnQ10ILylY5i1YhY6QpKmsgGaCEvLIU548+e+CLEVxLocTttB0PevHMHJ8Bbwz7BgT97g==
X-Received: by 2002:ac8:5fc1:0:b0:344:53f9:1871 with SMTP id k1-20020ac85fc1000000b0034453f91871mr8607624qta.448.1660582683198;
        Mon, 15 Aug 2022 09:58:03 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y12-20020a05620a25cc00b006a793bde241sm9274546qko.63.2022.08.15.09.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 09:58:02 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        krzysztof.kozlowski@linaro.org, rafal@milecki.pl,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] arm64: defconfig: remove BCM4908
Date:   Mon, 15 Aug 2022 09:57:59 -0700
Message-Id: <20220815165759.2502285-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803175455.47638-10-william.zhang@broadcom.com>
References: <20220803175455.47638-1-william.zhang@broadcom.com> <20220803175455.47638-10-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Aug 2022 10:54:55 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Remove CONFIG_ARCH_BCM4908. It is supported under CONFIG_ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/defconfig-arm64/next, thanks!
--
Florian
