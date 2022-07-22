Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C739C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 14:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiGVOeJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jul 2022 10:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:34:07 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E7539BBC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:34:06 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E7F21535; Fri, 22 Jul 2022 16:34:03 +0200 (CEST)
Date:   Fri, 22 Jul 2022 16:33:58 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.20
Message-ID: <Ytq1VnJNNaY+t6Kz@8bytes.org>
References: <20220719201004.GA15241@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719201004.GA15241@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 09:10:04PM +0100, Will Deacon wrote:
> Please pull these Arm SMMU updates for 5.20. There's not a lot here and it's
> actually all related to the Qualcomm hardware implementations. Summary in
> the tag.

Pulled, thanks Will.
