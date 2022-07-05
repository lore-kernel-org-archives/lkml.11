Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7F7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 13:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiGENj4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 09:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiGENjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:39:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E909951D4;
        Tue,  5 Jul 2022 06:00:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A18560F89;
        Tue,  5 Jul 2022 13:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B89CC341C8;
        Tue,  5 Jul 2022 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657026042;
        bh=9xMvBk8PyIWXazGIvBDDt8PNSTWLDQQ3EZxWzllP13k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWsFMqIrjKe1lrjKAq2geycNRNBmCSzI3khJuOFpZ1ftCHHbExpc4nKkJHNe9eDCw
         BQkCNlNMJP0wBJBfa15nvlYYQqRtBgbiHAqtGIfGtc2Fr4Ia8eJ0kRH/8dTUUxGrwZ
         DzkWdPa0PVhSN4ZCth/Qlrg8lPY5mdsEYRRrk7/G/+giyi1oveBwX1D8Rw5r0N/i+z
         D7KbBNM39rxD7kSkYmINPPiHxYr6BYHm0JoOPjOCiDH72m/F6kZCHmfTlPC+ON6F4Y
         d3neXXdEx24LnUU6iPNKwtazO4GlsOwZ3aJwU/DC8W9A4wicJLvMvsae4h9ItUIg6Q
         omPAMuby4cQ9g==
Date:   Tue, 5 Jul 2022 18:30:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v3] dmaengine: idxd: Only call idxd_enable_system_pasid()
 if succeeded in enabling SVA feature
Message-ID: <YsQ19ZlHmBNTzGgt@matsya>
References: <20220625221333.214589-1-jsnitsel@redhat.com>
 <20220626051648.14249-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626051648.14249-1-jsnitsel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-06-22, 22:16, Jerry Snitselaar wrote:
> On a Sapphire Rapids system if boot without intel_iommu=on, the IDXD
> driver will crash during probe in iommu_sva_bind_device().

Applied, thanks

-- 
~Vinod
