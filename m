Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DFFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 10:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384371AbiEBKOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 06:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384385AbiEBKNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:13:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AE56305;
        Mon,  2 May 2022 03:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EA2061230;
        Mon,  2 May 2022 10:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25B6C385AF;
        Mon,  2 May 2022 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651486224;
        bh=TMRGhDsQ5rlUJNgc/r4GHPu8kNEPVqY0brpK4SH6Z4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ammL2rugX2l643ddfB4/HsVMRNkcmuAcjYQirLhDVjU1GT4dSxbv0oAb4IlAQh0au
         1y9UYsfTZOhUPGiaOfUgiW9cD9HyN558tJFO2zQCg7cij+BymxfjMKk2PximvXXKC/
         MdTv+cg1OKsTIW2mxrxIKWx2txT+YcWnWBJeYDMyT+WKPefZUmoy6YgwaJRVhf+6bl
         WLDEBH2JqffsBuQYd8b9V/8MFj9wVC0bDh+ssR94no3JR4o0i2An+xaN0+SRmvJx71
         6HN2fCHb3tpzzCOg7uncUmAd+usYzhDN0ZoA8QwM9zobDgMasvJU2Pl+D3klWBI2kI
         OXQbdXs+W0lZg==
Date:   Mon, 2 May 2022 15:40:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] phy: qcom-qmp: fix phy-descriptor kernel-doc typo
Message-ID: <Ym+uC0eDP97q+lyy@matsya>
References: <20220420152331.5527-1-johan+linaro@kernel.org>
 <20220420152331.5527-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420152331.5527-2-johan+linaro@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-22, 17:23, Johan Hovold wrote:
> Fix misspelled "clock" in the description of the pipe_clk field in the
> PHY-descriptor kernel-doc comment.

Applied, thanks

-- 
~Vinod
