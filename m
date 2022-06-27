Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87EBC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 20:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbiF0UEn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 16:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbiF0UDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:03:55 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C6A1CB19
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:51 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-101b4f9e825so14319140fac.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uBL8T3g3R0Pq3whUkb/j5eJUSIuSh7+BTEsAjLrbttw=;
        b=tByXVs4oLqp70UnWrAelQLgAZ02AjGHlRCOv88PrYBSqr+tpiHU5Q+f/xG7zbiFenC
         tiSrYxs9TC477G06hNDlrjxga5jvL580iaOVQGS6EHHO8M55FCPlukXVJTUMpkwdzO5P
         bt9xGTTeA+6oUcHAnORPIsaOH90m5W/HxuLc0sGWNLScVokcy2cOBVkXLeqZNkhZR/HJ
         +9gIG3dMRBkp3pA91MTASZcI6SxfpD2vHTSBtwEsD9C/ME9MWc+SZNyA9AzpAgFu3TGm
         QNnpCpBGzCQzCXk0nqqQ1th0UuAX4myDZ9b36KaYhbKCKvwhJMxcWNugDfPdLOUI5ira
         AR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uBL8T3g3R0Pq3whUkb/j5eJUSIuSh7+BTEsAjLrbttw=;
        b=6sHdwY9TYNI2HycRM0D5XQpPsXviwfv2jSpvScDB8+DkU6dabIJ4teAq8JQHjUwWUG
         lLwPYhFB6KQp9aaweiUHO2JbPaizOAPEOsxymEsInTlUOsi3AADdlsMIGTJ70v49GrfM
         O+TLzTY+gvfL1vAxHAtyOTOoPgA7RupCrOKds7rIgxfC2yOkGWtjOtQYvfv38Yo8bkpd
         y1msT9MAbRMBDkWYqbHp1p5yE9mm5PNY3Sc69nK6MNXDVfWAviwRsXv0ri7H1ibYasXW
         T2H7HTmeYyhDftX842Bn5Lr9412j5KTdsQGzKSMg2sPpxRLzc+s191oU8x3Lx2z+QJnl
         QqbA==
X-Gm-Message-State: AJIora/rHgPRC8hol1r1qxfs0MyAD/CVvBwqwUSlna7vwGCY+ZQ4yvG9
        kwJF/S1z19BSLFHUgT5P/Gk0yg==
X-Google-Smtp-Source: AGRyM1uyXxkCopnKmMrwc7YTmNhF77XP6v4iLuNzB3mcEoxBcwwNkqmrJxoiPfBIjXYpp1D8SYTD2Q==
X-Received: by 2002:a05:6870:23a6:b0:f2:2dfd:d6d5 with SMTP id e38-20020a05687023a600b000f22dfdd6d5mr8502700oap.100.1656360230798;
        Mon, 27 Jun 2022 13:03:50 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m16-20020a4a9510000000b0041bdf977c6dsm6428729ooi.31.2022.06.27.13.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:03:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, quic_kalyant@quicinc.com,
        robdclark@gmail.com, dmitry.baryshkov@linaro.org,
        dianders@chromium.org
Subject: Re: (subset) [PATCH v7 0/5] Update mdp clk to max supported value to support higher refresh rates
Date:   Mon, 27 Jun 2022 15:03:04 -0500
Message-Id: <165636016347.3080661.10709114868531823730.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1647919631-14447-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1647919631-14447-1-git-send-email-quic_vpolimer@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 08:57:06 +0530, Vinod Polimera wrote:
> Drop the assigned clock rate property and vote on the mdp clock to
> max frequency during bind/probe sequence.
> 
> Changes in v2:
> - Remove assigned-clock-rate property and set mdp clk during
> resume sequence.
> - Add fixes tag.
> 
> [...]

Applied, thanks!

[2/5] arm64: dts: qcom: sm7280: remove assigned-clock-rate property for mdp clk
      commit: 5241fd7fee9bee0cffa33f6d074194e94831e467
[3/5] arm64: dts: qcom: sm7180: remove assigned-clock-rate property for mdp clk
      commit: aa4ae511a760e66f22641d9b9b6052b469df3c10
[4/5] arm64: dts: qcom: sdm845: remove assigned-clock-rate property for mdp clk
      commit: 0b24829fd74cf954b3a02e9e4c4da3c098c69fbc
[5/5] arm64: dts: qcom: sm8250: remove assigned-clock-rate property for mdp clk
      commit: 6edb323837909462d493f22c07a38a23ef44f944

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
