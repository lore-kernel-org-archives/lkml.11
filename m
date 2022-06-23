Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E5BC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 05:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiFWFAn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 01:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiFWE75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 00:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DDA4757E;
        Wed, 22 Jun 2022 21:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FB0661D9F;
        Thu, 23 Jun 2022 04:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B22EC3411B;
        Thu, 23 Jun 2022 04:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655959505;
        bh=8J5XzRXKCQg6iNeiwqkBH23n+Jff4Ghbd9kkfc4aj+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YEsWtWuSD/omnLBZzdoOKY0Xqqd0ChyirSmQBp7drr87/8Q2adBFAgq1nuqgJsG1Q
         AtKv0+PnmfSl1oYf38a2uXJh7nKqKDaOJUZCRE0d7HIET0BTy6ILMg3hQ3BYnxwTMz
         Sq3cNXk5LSg1LvmQgL1Osp6Xl0f+3277sQkQ4vFOzdHkXx6E2eTsWvtiqzk0X5LY4D
         Mm3BtI+6lkve9D/z0cVKQXLtl8TNKEiZOQ6TaO3aeyT9vuP2GTL+y4k4345EYmlnVa
         ff7tIWkz6jZ4ENANB2quPKFZdFzyOO4Uy5WefIrU3dEjtr0Sne+aHAbwg5fGLzwv6A
         8Iz/fI1SlAQ/A==
Date:   Thu, 23 Jun 2022 10:15:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v7 4/6] clk: qcom: add support for SM8350 DISPCC
Message-ID: <YrPvzbYlDOLKSmUj@matsya>
References: <20220622232846.852771-1-robert.foss@linaro.org>
 <20220622232846.852771-5-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622232846.852771-5-robert.foss@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-22, 01:28, Robert Foss wrote:
> From: Jonathan Marek <jonathan@marek.ca>
> 
> Add support to the SM8350 display clock controller by extending the SM8250
> display clock controller, which is almost identical but has some minor
> differences.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
