Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A06FC433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 11:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243322AbiEZLJC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 07:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344568AbiEZLI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:08:59 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BE9C966F;
        Thu, 26 May 2022 04:08:58 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 339611C0B8F; Thu, 26 May 2022 13:08:57 +0200 (CEST)
Date:   Thu, 26 May 2022 13:08:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: qcom: msm8974: Add missing license headers
Message-ID: <20220526110856.GF5138@localhost>
References: <20220421211936.345168-1-luca@z3ntu.xyz>
 <20220421211936.345168-3-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421211936.345168-3-luca@z3ntu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> All other msm8974 dts files are licensed as GPL-2.0 so add the same
> header to the files where it's missing.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Normally, dts files are dual-licensed. Can that be arranged here?

	      	    		       	   	   	    Pavel
