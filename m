Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5252C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 14:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346573AbiFOOUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 10:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345175AbiFOOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:19:57 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEA843EF5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:19:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id c4so19129645lfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=A9RmSO/OHnan4DfbcCHEVVY9M4r3MnYRFQBaUW6bNWA=;
        b=MNuMF3PuaRY/+6YKpSGtGwP/4IuvRcZKjZOwztV73IB8RG1NWUXPWaU2BFUwCr5ux6
         nBrrd+8xchQCtImhgEfLaO4XTIbMV5XSVMTLk6ED6SSBDT0nTF4DGaiqTC5iP57OnHyd
         UnMT+znTe8UDArIKd/v8jCrb2b01rK/7rRWt77ff2CTsrz/hjzgoF/Q79oG63L1TXG8b
         ODyf6yIpWkuPxejCxOUmlcetemEUmOZJ/PHWn0J42S4FAhLHKTsGRd/YiVUb0Kd/SYd7
         u2l+ZoFA8i/WTSrXUIWOCnXlVFg0Im6YEETIIqQZfPzvhp+69RfGTUlaHICOsYkfT2DP
         jaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=A9RmSO/OHnan4DfbcCHEVVY9M4r3MnYRFQBaUW6bNWA=;
        b=h7G+PwIq8xzcFQXbfFRs5nPhZhOEnaXuRdw9RjPYcJXn9te24866406xxQcWDN5UKP
         dsfo1+MH4pfYtO8DdygY8TMFSpswkXJWE9xta15ulKDlSHwMS+1YspcgzOCX+fuVTpqa
         3Q2AnRzxZTDObGWTSMRrVW1D2G3pq5/OXp5SFL/z9Z+B+ZKo0ATtkLSAeGCnZh4SAPop
         wRRqMhcooWo1l/FTs80c+P4Dr5goQfTJ6yVeb/RAgOII6rE5dsZQiLiqNMN5PJ5fWmNX
         PGwPXruK2U+vYI9vm0mYTtWjyJIG6h1VHEGJdyzMN9Amkg8J5pcEVC3kb293vtY1DYfR
         tIDA==
X-Gm-Message-State: AJIora8d6ItrQGQ6jCnIEk3ko3I7Fu0YDnPt+SGtI820FOSJj2d4cpIR
        TYQizbXf+8VBzBhaMj887k7/HA==
X-Google-Smtp-Source: AGRyM1ugCc/2OaezlkOsaaKljgQlyk2WvF+Ik7GaQdltNSp7JiRkOQRFbTxT/C1eeTM0SUyJMfAG8w==
X-Received: by 2002:ac2:58d6:0:b0:479:5b9:74a with SMTP id u22-20020ac258d6000000b0047905b9074amr6019118lfo.551.1655302783810;
        Wed, 15 Jun 2022 07:19:43 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v5-20020ac258e5000000b0047255d210fcsm1818418lfo.43.2022.06.15.07.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 07:19:43 -0700 (PDT)
Message-ID: <5dbc0159-cb33-db5b-20cc-05f3027af15e@linaro.org>
Date:   Wed, 15 Jun 2022 17:19:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Please add another drm/msm tree to the linux-next
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

I would appreciate if you could add

https://gitlab.freedesktop.org/lumag/msm.git msm-next-lumag

to the linux-next tree.

This tree is a part of drm/msm maintenance structure. As a co-maintainer 
I collect and test display patches, while Rob concenctrates on GPU part 
of the driver. Later during the release cycle these patchesare pulled by 
Rob Clark directly into msm-next.

During last cycle Rob suggested adding this tree to the linux-next 
effort, so that the patches receive better integration testing during 
the Linux development cycle.

Thanks!

-- 
With best wishes
Dmitry
