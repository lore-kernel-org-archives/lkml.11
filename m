Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED3AC28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 17:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbiHVRQG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 13:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbiHVRP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:15:58 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DEC1D33B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:15:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bn9so3697134ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3B91h+yrTjwS7I4FUx77uKxPNz+E7GshMHnIapiZTc8=;
        b=L9QS1hKwgWBMx6ma10ELOh9eQnoZAT8Szdd1iSgK+rhGHKoZ6Mtm7TdVEyday19ApG
         R3x87oAm5OhNvqgvSNUuuRIalt/FEzvZraWsVRATJVhrk2zNUxrDG1DaPfqa1gnvRiET
         GrjSk+xWXT3q1YI3kCSOaTd1UTyO1DACmUkCAqSUglcPKmJP1VWpzOVBZaafRTN020KX
         qgfAE13dDMgRhUjuX7bsxL0AleLwvYnfTTynsdyZJ0GrQ26JoQvufwKvqsGlC2wbb9YA
         nfXmXt03p+fYISvL3GLe/omMfhMvZoA6T2eo0unJ3CCi/WCwLifw7v7K7vddOmcEa/u+
         O91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3B91h+yrTjwS7I4FUx77uKxPNz+E7GshMHnIapiZTc8=;
        b=wMsF45ZLUAUeg91PI4HHfFdusxyP6EYj7zCemVgWtbdSlIBHczaaIT7G278X9592GI
         9VPXGBZt178RvQIzdRKULw0m5weWIkO5lqNdR8Cu2fpdr+HK9pttqhlgLKrYXn5OWkAW
         CUZZR0aAXzjUA5MVP1DdKbr2Uxa58Op9hkh+bnz3JrrTlC1KPvQglfuQ38cAe95wsiAg
         4lI15OQ/cHfDH4+SunbGKeIqjv1+5YIMOtJkLyl9iaz9hYSCfx3Rl9YZ1BKWLiZkpnMz
         fDazNJ32kkBOe+Rb1qr5btwfUB4vzb3xfTICfxxF8O0rbOBgWFcOp48uyKR9fRbWYnAD
         fbkQ==
X-Gm-Message-State: ACgBeo0QEO/st+rpFF+VIfG0+vaIna8AyI/UFJjZJdDBsMIZZ97ujdiZ
        nMcjMyRvifmUYrex5Hmtq6c1Pg==
X-Google-Smtp-Source: AA6agR45NEMpbO0Z9AzrrsVon/LA0ZrvVtjVxutO5v+1o6P1YNcB95+XrUkQ2XHqrbFf16qxDUfE0w==
X-Received: by 2002:a2e:3314:0:b0:261:d144:faa4 with SMTP id d20-20020a2e3314000000b00261d144faa4mr1232145ljc.208.1661188555755;
        Mon, 22 Aug 2022 10:15:55 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651203c900b0048b0bf9f4bfsm2010195lfp.140.2022.08.22.10.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 10:15:55 -0700 (PDT)
Message-ID: <f0016468-16f9-aca1-c362-805bfd141e57@linaro.org>
Date:   Mon, 22 Aug 2022 20:15:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] drm/msm: De-open-code some CP_EVENT_WRITE
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220821155441.1092134-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220821155441.1092134-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2022 18:54, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

