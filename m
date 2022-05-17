Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E81C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 13:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346464AbiEQNkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 09:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244994AbiEQNkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:40:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E0648392;
        Tue, 17 May 2022 06:39:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w4so24786660wrg.12;
        Tue, 17 May 2022 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DsBS2/0Li2RTw7178mLULg48Zs19XBetfneW5cg8piM=;
        b=JzTtfBTPN6klmcyWZvGAuDo41K7gC3NRB/ZnLbSQve78vTlIPseVgWEwQcbngEAnsm
         Ev9YEst0Skd9z8uUrnTWNhZry7G9ms9XoMIx54ZkTxjSge7JYwYf2rspETUsoRlw5n8+
         mRJnGORLr27OoArd3j3oE3EBFZZhCsAOvsGtL71RJOnnSweBs3QiHQxEjiKIqtAxkEFb
         ybUIJEerOjiltVv7mrnm7UTqneqDuZUFOnXnaB1Uvg+wxEd7H87R3s434KY7eVQSE/4X
         VTsJvAJnaxRgu7VoMnFkjaKLPeu1dwItjJwdThTLn0S37zO/owu/gxr5Uz6iaOCJi5bA
         ibTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DsBS2/0Li2RTw7178mLULg48Zs19XBetfneW5cg8piM=;
        b=lw25LkxlPtiVIa82ZcJ5dU2lAsNVofPDBVraUsJhzuEhYmDlJJAfnStqheQ5+tllJy
         kGbEXJmuKeweZ90mHKSlGtxqkKuR9QPQkg7+5Iu9VaPpOWDszvD4EOnszVODtFQBSmO/
         bfPA9pZp/ifRoDpv3XSoXF4WTHiPbSwtFqvvv0hbrGb95p83/6L9f48R35IPkrRSXmDM
         DYzN7hrQA3S/rtUIjr4H7MVKTu8JNqtALgolW/l/ek2DxIzY7Cg5dNAKK3kVeK9Vn5R6
         a1WHVhtqtkedhvVJEmK2AKPlD2G3prmX3Iyeo3hvuVqPwgso8ZClMnelU/fm2AafcY4d
         EJwg==
X-Gm-Message-State: AOAM533dJoJqlH85Tb/Oeuivg5u2Ew38EDRqEOzAk9d0k2VmInlXPUVX
        M/g1VEGVr1oRYlvO8ZrfAuM=
X-Google-Smtp-Source: ABdhPJxWrjm2QUO2A8gYNnTZ7koN2aGc20TGB2/o9TVputiWZLQC99N41GyCU4zmF5peUzLsT4aYdw==
X-Received: by 2002:a5d:4649:0:b0:20a:e17e:56de with SMTP id j9-20020a5d4649000000b0020ae17e56demr18783120wrs.450.1652794798225;
        Tue, 17 May 2022 06:39:58 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id d7-20020adfc807000000b0020c5253d8e4sm12056061wrh.48.2022.05.17.06.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 06:39:57 -0700 (PDT)
Message-ID: <21581440-a65c-ee8c-95e4-0e179c2838dd@gmail.com>
Date:   Tue, 17 May 2022 15:39:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/6] dt-bindings: arm: MediaTek: Fix clock bindings
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        wenst@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220517101514.21639-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220517101514.21639-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/2022 12:15, AngeloGioacchino Del Regno wrote:
> As per Rob Herring's review [1] on my mt6795 clocks bindings patches, for
> which I've used the already upstreamed ones as a base, it was found that
> these bindings have some issues.
> This series is addressing the issues that were found by Rob on my series,
> which are present on all of the already merged bindings.
> 
> [1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220513165050.500831-5-angelogioacchino.delregno@collabora.com/#24859953

I would say we could squash patches here and make it 3 instead of 6.
In any case for the whole series:

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> 
> AngeloGioacchino Del Regno (6):
>    dt-bindings: arm: mt8186-clock: Remove unnecessary 'items' and fix
>      formatting
>    dt-bindings: arm: mt8186: Set #clock-cells as required property
>    dt-bindings: arm: mt8195-clock: Remove unnecessary 'items' and fix
>      formatting
>    dt-bindings: arm: mt8195: Set #clock-cells as required property
>    dt-bindings: arm: mt8192-clock: Remove unnecessary 'items'
>    dt-bindings: arm: mt8192: Set #clock-cells as required property
> 
>   .../arm/mediatek/mediatek,mt8186-clock.yaml   | 29 ++++-----
>   .../mediatek/mediatek,mt8186-sys-clock.yaml   |  1 +
>   .../arm/mediatek/mediatek,mt8192-clock.yaml   | 46 +++++++--------
>   .../mediatek/mediatek,mt8192-sys-clock.yaml   |  1 +
>   .../arm/mediatek/mediatek,mt8195-clock.yaml   | 59 ++++++++++---------
>   .../mediatek/mediatek,mt8195-sys-clock.yaml   |  1 +
>   6 files changed, 71 insertions(+), 66 deletions(-)
> 
