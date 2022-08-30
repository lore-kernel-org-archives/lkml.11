Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6584C0502C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 07:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiH3HEp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 03:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiH3HEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:04:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1461A0308;
        Tue, 30 Aug 2022 00:04:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C0016148D;
        Tue, 30 Aug 2022 07:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F010CC433D6;
        Tue, 30 Aug 2022 07:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661843080;
        bh=T/j3QvsG4mB6yh1hvgD+vOaPefVUrCtRE0XdtXtVj0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+F4UXriOFnswgh1EJjzDzmfORpvrKiTobS+i0f3/AI18BVvTBBShp0PEC72u3kEP
         VjWC9JWAHCQq4NcjL9WQ4Nqnqv9GZ/uYkUdMpnsfuhFWx8H4XsEkL4BTzODBqHTCe9
         ePmOupetsXBWbnna316Xw6Oi5s80CvN1mzRB7W4m011cPLZDDd/pHcng5gqHoB5kk7
         xdglVV91dXxVqgKpzBd4dhjc3iGzjI7lv5wrNfoowYY2aWPwJbu0bTm2PChj+j9I2a
         htZjQGUihY7OIkjFCXZ3/3wrJSjrB8gDft4UHKuBBW5fR1UrqkP0rre847ZrbnWasT
         hLiV2YbVnZNJA==
Date:   Tue, 30 Aug 2022 12:34:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: phy: qcom,usb-snps-femto-v2: Add SM6375
Message-ID: <Yw22gxB4is7hsrcH@matsya>
References: <20220716193257.456023-1-konrad.dybcio@somainline.org>
 <20220716193257.456023-3-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716193257.456023-3-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-07-22, 21:32, Konrad Dybcio wrote:
> Add a compatible for the USB PHY on SM6375

Applied, thanks

-- 
~Vinod
