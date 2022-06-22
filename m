Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AD8CCA47D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 10:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbiFVKOu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 06:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiFVKOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:14:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936B13A5F5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:14:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i10-20020a1c3b0a000000b003a0297a61ddso171544wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZGMHT1uhjCKvxJm1ObjOuYivPXVQOnihHYXcGYcwvas=;
        b=nKEBuDo2khsFXyhhiCOkz3xLQFq3fpyOaakLCcIfD0KQAYYeMqHG16/xfV/Jh5RvAh
         M8m4z3dO2KOg2upsEK1hxI3CvHEsyBaeFn/Svcx/sepUahoZyVs9lMsnFu0REWnTl+kd
         bMXxgXxU4oyqzJNctDhaCrhitdpZhCJHSmHqFNPFxjnhQz9SurO5mUjZtf9xatk5TSBA
         ojl6+imXM7cXFJd8DipOpp1sfoofm2Itv9+eD3alkAbv/4rA2ihQD5QyhX694kNJIMP3
         XM7D0ku5dxdl+h+JBX3bxtI4y9S2gNR5SUX4EDLy99hrnxo665PzGWJHzq0Ba6+wKyOY
         kbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZGMHT1uhjCKvxJm1ObjOuYivPXVQOnihHYXcGYcwvas=;
        b=RdMo9puFDuEENroBXHAFGZjkMTe3PjHq3YQKdmicFv5DBmdrSjYq+C4icKHfu9KsDk
         hChXNyVHVTvSSQgB5nbdlWfMqXRyj136b4kshOxyPSjXTAraGnM9if9yHE4gqRlI3aaf
         UZdnJXCHws1924z6YY6bNcn6exxDJdxGa89Qy23GDcrJ2OUQzdw2RyntlhmKrsgj3f8n
         vmE1t4NcD/e4MLohLKnJOELvD2tF0QkRqubqfqlVz4KYyLRQtWf4d2xKKrnqJZmyRML9
         YqscUdgBAuu4tSKuqzowFoFL4c+7yp1gtKSvNTC9UR7bLMavarSs0ORRwGKcxSyhWhX/
         sPKQ==
X-Gm-Message-State: AJIora+YlIG+Bfll/VYDG6e85ZaJszv5tNOGN1nQCys6P0j22XvBHzKL
        054QFr7Z7f+HvHfYvRrQhO7sveLMuN5fOA==
X-Google-Smtp-Source: AGRyM1v007oGF6GyrHQNq0+BOyS4cdvxLvwNXS3/IfxgfWnvBjzy2ucrJT/HKxalC4BaUp9+fdNlSw==
X-Received: by 2002:a7b:cb88:0:b0:39d:16a7:dac7 with SMTP id m8-20020a7bcb88000000b0039d16a7dac7mr3060353wmi.128.1655892886072;
        Wed, 22 Jun 2022 03:14:46 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w5-20020a05600018c500b00210320d9fbfsm22184549wrq.18.2022.06.22.03.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 03:14:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David_Wang6097@jabil.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        edward_chen@jabil.com, ben_pai@jabil.com
Subject: Re: (subset) [PATCH v5 3/3] dt-bindings: arm: aspeed: document board compatibles
Date:   Wed, 22 Jun 2022 12:14:43 +0200
Message-Id: <165589284658.28441.5142469500178504592.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220531011100.882643-2-David_Wang6097@jabil.com>
References: <20220531011100.882643-1-David_Wang6097@jabil.com> <20220531011100.882643-2-David_Wang6097@jabil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 09:10:59 +0800, David Wang wrote:
> Document jabil board compatible.
> 
> 

Applied, thanks with fixing up the white space.

Please be sure git format-patch and checkpatch do not complain on your patches.

[3/3] dt-bindings: arm: aspeed: document board compatibles
      https://git.kernel.org/krzk/linux-dt/c/ae8980247d5af8528145713e07f1338abc57a00d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
