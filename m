Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52037ECAAD8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 07:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiH3Hhy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 03:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiH3Hhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:37:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E53BC80B;
        Tue, 30 Aug 2022 00:37:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34C96B816B3;
        Tue, 30 Aug 2022 07:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D544C433C1;
        Tue, 30 Aug 2022 07:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661845064;
        bh=do/CEPvPzbL9rrFY1oLtzcW1Fx3Fax9iXYI3vbjDfOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rs/P+uFpB+j9/CvS5EAk2RxilWTBlp9SqjTiMNgz8CfIeXmazcFsQ8ubw1f9Ppii0
         XI0jyulU7+LjmZJ1RKXdMR+LtJMXxpVZzfA4G5ZJSnExA2ba2yzkBZAoHgtjZsBP46
         fl9Tvj/zDiTn9E4YGAD2qfRam8wKWfh3aumQJfuCpoarCkzP/v2vGwaAjLa0YGStI0
         KvV1s/wP/skbOPBw5EM/ybW1ySH7ag3Gqi7NepyXeI2DXlOdz32NR2wIpJbYjDEFHm
         5rW2JANX66F0QPC9Yjszd5wHf//UQq8g/yprnOWOkt9VJ4GP7mv9JVu+OFT+s8qDvQ
         gIwXSXFr5/J4A==
Date:   Tue, 30 Aug 2022 13:07:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qualcomm: phy-qcom-qmp: add support for combo
 USB3+DP phy on SDM845
Message-ID: <Yw2+RSv0yG3XS+ji@matsya>
References: <20220810030926.2794179-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810030926.2794179-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-08-22, 22:09, Bjorn Andersson wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Define configuration to be used by combo USB3 + DisplayPort phy on
> SDM845 SoC family. It closely follows sc7180, however like the main USB3
> phy it uses the qmp_v3_usb3phy_cfg config.

Applied, thanks

-- 
~Vinod
