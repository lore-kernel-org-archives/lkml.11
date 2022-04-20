Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F87C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 09:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377101AbiDTJRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 05:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbiDTJRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:17:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B670831903
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76771B81D71
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20E4C385A0;
        Wed, 20 Apr 2022 09:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650446055;
        bh=YkQ1BmgnVigFA6crl28MszPDelfUPLDxv+xYc2hZRn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qSCP5bRgdtkG5ATn4Ptdiy+vscoyQ4iSOfOzruELSKXONsYoiFZ5EKiPoyGGG3FBD
         oiwMUVKb5m2ySu5hKHppfWdDE5qmX6C6PamGD1E9T/ARojLwaNV2QH8PHT3S2ZbHqj
         zY4BnASVL6D8FAv8zSwu2hn26QIFYjJct48t/DC3xSc12Sns8evZ1G7T7+HbZBYNfi
         LyjlxMSeZ2GDM3+qXepCAhEuR0mAf4yyw5pn23rn/dQn+kP4gk9oaPsLPNzTOxyd2g
         ANa+E6lD2XmzYUrSNWnOYHwTzOPmgJpwL9ADAFpoJc1OHwQ/ZdbIRsDbmXlKUfR48a
         5Gvg8z/ClfINg==
Date:   Wed, 20 Apr 2022 14:44:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/6] phy: rockchip-inno-usb2: RK356x OTG fix and
 enhancements
Message-ID: <Yl/O4uCTlacfw2Pl@matsya>
References: <20220414032258.40984-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414032258.40984-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-04-22, 22:22, Samuel Holland wrote:
> This series gets USB OTG working on the RK356x SoCs, as used in the
> PineNote tablet.

Applied, thanks

-- 
~Vinod
