Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E8CC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 10:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiF3KuA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 06:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiF3Kt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:49:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2125126ACF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD003B82A19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F6AC34115;
        Thu, 30 Jun 2022 10:49:54 +0000 (UTC)
Date:   Thu, 30 Jun 2022 11:49:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable memory hotplug and hotremove
 config
Message-ID: <Yr1/zr3LVzxLTlbG@arm.com>
References: <20220629093524.34801-1-wangkefeng.wang@huawei.com>
 <d4b409dc-b388-187d-4792-24909048a9ab@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b409dc-b388-187d-4792-24909048a9ab@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 12:40:44PM +0530, Anshuman Khandual wrote:
> 
> 
> On 6/29/22 15:05, Kefeng Wang wrote:
> > Let's enable ACPI_HMAT, ACPI_HOTPLUG_MEMORY, MEMORY_HOTPLUG
> > and MEMORY_HOTREMOVE for more test coverage, also there are
> > useful for heterogeneous memory scene.
> > 
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> > v2: add ACPI_HMAT and update changelog too.
> 
> In general, would like to see MEMORY_HOTPLUG/HOTREMOVE be selected
> here for better memory hotplug test coverage. But not sure whether
> there had been a rationale for not enabling this on defconfig.

Probably we didn't support the first defconfig was added and forgot
about it.

-- 
Catalin
