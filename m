Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA90C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 18:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349062AbiDKSGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 14:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349050AbiDKSGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:06:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FB437BE8;
        Mon, 11 Apr 2022 11:04:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54BA160FD2;
        Mon, 11 Apr 2022 18:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275CEC385A4;
        Mon, 11 Apr 2022 18:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649700273;
        bh=MuQab/xaawBX0nLDyPNsiNOXlr4TZ0C1l+8XGJX/Rzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AMWzoBKSQFwn5Xn+Jo9g5l8lpG/gy5gTwOoLzQnS34q7A5xpbxHssn9jFccKe6Zfh
         QxWkxp3QcgstyPxAmpblD2IVLfvLjOPCMehsLYCld6BjnfLm/i9Oahdks1S8ca0DPT
         s2KpeXE9p4/wiDNBOsFwzjRUP36Vdevb4hPEz0/RB38ZBKrJ6QFgLzo6FDlJbJI4xL
         dZj+0q7zLT7BsVlGqjZQ1e6xC3cPu4gHJQ+t0wlDHzL8ihsgruWyAlAoJ7gGe2jLly
         2pUd3K4Ye5piIXxsnOZgApkiUZ9ZIQsb1xAafiEk0I8Glog+Byk9zDhC1QOZHVPbxa
         DDBFYu8QTxCdQ==
Date:   Mon, 11 Apr 2022 23:34:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] phy: qcom-qmp: Add SM6350 UFS PHY support
Message-ID: <YlRtra5AZAw2NWMT@matsya>
References: <20220321133318.99406-1-luca.weiss@fairphone.com>
 <20220321133318.99406-4-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321133318.99406-4-luca.weiss@fairphone.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-22, 14:33, Luca Weiss wrote:
> The SM6350 UFS PHY is compatible with the one from SDM845. Add a
> compatible for that.

Applied, thanks

-- 
~Vinod
