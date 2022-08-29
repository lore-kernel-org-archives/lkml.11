Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7C6ECAAD8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 23:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiH2XrB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 19:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiH2Xqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:46:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322D7A2DB5;
        Mon, 29 Aug 2022 16:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C2E4B815DD;
        Mon, 29 Aug 2022 23:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086DFC43148;
        Mon, 29 Aug 2022 23:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816790;
        bh=MQxKOKIBts95P9DbjiHNKkmrVfq6Kli774rOeB7RZ54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FOLSmb+/Aey4/Uom62H1GtDKwQSkqs5sL6SpgNuFUimM2lvAS4Ki8Hrs98io/oajJ
         4h0gRcIlyVUnH6B8Lr295kU46jFgtomu330S/nLbTrbQTuFbUPEaPWuWHKyzNc55RT
         7GxapW6BRBK8vMFbI8laWJ9icnVZMx++EyxkzB5pq2vQUzvtalSwsaOiiEoSaLYvkl
         M40aCPpZTPCL0A+b5QpEWdyUjJ8bf8bwM24jiOl9Kw1w8JxbJv46Nf2+HXmeO05dDL
         MrnuHpEZJHCRZwdQ6JtDjGAivAbp7TPqcgoBEFYZidrrwC9TdoybhDKZ1vV9cHXPb0
         xI/r+SKioD0Ww==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>, johan+linaro@kernel.org
Cc:     quic_ppratap@quicinc.com, mka@chromium.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        quic_pkondeti@quicinc.com, quic_kriskura@quicinc.com,
        linux-kernel@vger.kernel.org, quic_c_sanm@quicinc.com,
        konrad.dybcio@somainline.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        quic_vpulyala@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: move USB wakeup-source property
Date:   Mon, 29 Aug 2022 18:45:52 -0500
Message-Id: <166181675985.322065.9753158568799814599.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220802152642.2516-1-johan+linaro@kernel.org>
References: <20220802152642.2516-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2022 17:26:42 +0200, Johan Hovold wrote:
> Move the USB-controller wakeup-source property to the dwc3 glue node to
> match the updated binding.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: move USB wakeup-source property
      commit: d5089f79b1e4fad445daa48382380a7e584603e2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
