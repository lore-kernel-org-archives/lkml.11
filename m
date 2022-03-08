Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D20C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 11:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346265AbiCHLWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 06:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346155AbiCHLWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:22:12 -0500
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02181D33E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:21:16 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BB7147BB; Tue,  8 Mar 2022 12:21:14 +0100 (CET)
Date:   Tue, 8 Mar 2022 12:21:10 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.18
Message-ID: <Yic8JopcUs2aqv4p@8bytes.org>
References: <20220308101810.GB31063@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308101810.GB31063@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 10:18:10AM +0000, Will Deacon wrote:
> Hi Joerg,
> 
> Please pull this handful of Arm SMMU updates for 5.18. Summary in the tag.

Pulled, thanks Will.
