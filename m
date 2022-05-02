Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9089C433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 13:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385121AbiEBNFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 09:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385103AbiEBNFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:05:34 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39F3186D8
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:02:05 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso9648068otf.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 06:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CtdcU9l/eHtmGbmVAGb3hipx1MyfPt8hYs/X++xA/Z0=;
        b=Ya3yCRPVQavN50597Nmysg2ex7niSVKPfGsl0FDOOHtfjZXz++DXVIqM8iQl8IqIye
         qlWQa6rT4Ka/uZGAYXrQeJ6vNKimjSASuzOG3/6NC6G3TIvyTUrlqLMVxCMR6AqP2rG0
         xGRql6dU/PdZryV+hLB7vHjgHl+f4WslJAGQJLD/AwgFMcPWv/ClHmui+T7kXVfjYeHB
         3owCU4xxX/DeC/MwGYNlNHq29MTdTr+6qF0kCLktPVvZ++mreh4nuzgxpH2moBRafT6M
         v9SUunzFZmzZz2+ZF8+CbACMhPE4bRWSVu5sWCg6m6MfTEK8UQDPa3WO04K+RLkAcVBf
         3MTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CtdcU9l/eHtmGbmVAGb3hipx1MyfPt8hYs/X++xA/Z0=;
        b=aPYkoF3aBEdWv9YOJaEmwxfk8b1jVi8Xv4JoWTS2pBmzx54G8hqoWidYBzNaLD9hTw
         1KyYudyG0JD29zmn5/oCbc32JToT1ahru+oEqOQZcxeF1Sw3c/0x4HGGR2NfAMb6ai78
         83NIweDIg2Y43Zohqxq0no18YWsErJtnzaAEB5lU8XenoQnSMI6zx4W98sqe418HSktu
         0m2u1wrHf31D9nIFyeFzCYEoyeLTY1P0tItu6t55UgpdQRWS/+Aj48rL3jkiIMr+Fx7W
         jlcFpTJvp+VfSfmsOuU79jeD2KlSZut8dkCaZj/eF2SQ1CtoAQwpsuLmnroQNKCRqoCG
         VrVg==
X-Gm-Message-State: AOAM530UFkWN2Rb5Wqejf+wBsgz63TgP9ejlrds8slSzuzeHI44+K4p0
        Nkdrc+Uw7KtBP1RK3/esHMfiOLHp0kw4oQkd
X-Google-Smtp-Source: ABdhPJx2sMpmpPcUY0yXRX7INEvhJoOBK+SadoHUezaQq8ZRTfpqOrIOAL9cLBu8v6P+b1R6JS/R9w==
X-Received: by 2002:a05:6830:4b4:b0:606:1c6:9c1 with SMTP id l20-20020a05683004b400b0060601c609c1mr4066231otd.255.1651496523716;
        Mon, 02 May 2022 06:02:03 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f9-20020a0568301c2900b0060603221247sm2814962ote.23.2022.05.02.06.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:02:03 -0700 (PDT)
Date:   Mon, 2 May 2022 06:03:50 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v2 2/3] phy: qcom-qmp: fix reset-controller leak on probe
 errors
Message-ID: <Ym/Wtqjpdgaaf2tp@ripper>
References: <20220427063243.32576-1-johan+linaro@kernel.org>
 <20220427063243.32576-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427063243.32576-3-johan+linaro@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26 Apr 23:32 PDT 2022, Johan Hovold wrote:

> Make sure to release the lane reset controller in case of a late probe
> error (e.g. probe deferral).
> 
> Note that due to the reset controller being defined in devicetree in
> "lane" child nodes, devm_reset_control_get_exclusive() cannot be used
> directly.
> 
> Fixes: e78f3d15e115 ("phy: qcom-qmp: new qmp phy driver for qcom-chipsets")
> Cc: stable@vger.kernel.org      # 4.12
> Cc: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index a84f7d1fc9b7..3f77830921f5 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -6005,6 +6005,11 @@ static const struct phy_ops qcom_qmp_pcie_ufs_ops = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +static void qcom_qmp_reset_control_put(void *data)
> +{
> +	reset_control_put(data);
> +}
> +
>  static
>  int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id,
>  			void __iomem *serdes, const struct qmp_phy_cfg *cfg)
> @@ -6099,6 +6104,10 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id,
>  			dev_err(dev, "failed to get lane%d reset\n", id);
>  			return PTR_ERR(qphy->lane_rst);
>  		}
> +		ret = devm_add_action_or_reset(dev, qcom_qmp_reset_control_put,
> +					       qphy->lane_rst);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	if (cfg->type == PHY_TYPE_UFS || cfg->type == PHY_TYPE_PCIE)
> -- 
> 2.35.1
> 
