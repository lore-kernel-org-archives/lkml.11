Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412CFC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 15:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352714AbiEDPu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 11:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiEDPuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:50:19 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8DB1F638;
        Wed,  4 May 2022 08:46:41 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2446CVlS001835;
        Wed, 4 May 2022 10:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=p42V5ez2ytHkxPwvm/E53lyOqEf0evRrrxzngdj5JI4=;
 b=fTUa/RFdOzTnC7R0c1hzbG9eEZyokEkorMrW9JLMnSof2NFbkIBc+5AZEQ/jNYV0IESY
 7bhooASG5z2naTYP0UhplsIrTNazi2VsY1rmPcus0cTjSODTwbtQD40e7LLOEHlwMV9n
 EtQsiB2w3p56ToM3IkTJhRl+YrRd/bmHlIUwUnLaT2yu1+xORU6wDY1GIqoKRqyJCtgI
 Ueg9XxhS6qpI7UEiJVhi0x2FUJ9po3i+HMQR6N+1nmG13ahiK3RhrQhtegH77uJoCMoN
 JQrF+FdSqydyeJGuP8N+ejS11rLo9PtCIl+Rx4IiDvcnlQuZeuZz/lWTYDP1uj/tqbmD QQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fs2h2d5ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 May 2022 10:46:36 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 16:46:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 4 May 2022 16:46:33 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B04C3B10;
        Wed,  4 May 2022 15:46:33 +0000 (UTC)
Date:   Wed, 4 May 2022 15:46:33 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: mfd: wlf,arizona: Add spi-max-frequency
Message-ID: <20220504154633.GU38351@ediswmail.ad.cirrus.com>
References: <20220504084304.46173-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220504084304.46173-1-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: OtO85VfaQVfqKJ4G52mIbzcAUOY3X93P
X-Proofpoint-GUID: OtO85VfaQVfqKJ4G52mIbzcAUOY3X93P
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 10:43:04AM +0200, Krzysztof Kozlowski wrote:
> The Wolfson Microelectronics Arizona audio can be connected via SPI bus
> (e.g. WM5110 on Exynos5433 TM2 board), so allow SPI peripheral
> properties.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
