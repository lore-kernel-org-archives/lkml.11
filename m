Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32F5C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 10:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiF3KxP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 06:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiF3KxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:53:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EED9FC7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:53:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25D0DB82A28
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0850C341C8;
        Thu, 30 Jun 2022 10:53:07 +0000 (UTC)
Date:   Thu, 30 Jun 2022 11:53:03 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] arm64: defconfig: Enable memory hotplug and hotremove
 config
Message-ID: <Yr2Aj8nr6izMsmmX@arm.com>
References: <20220629093524.34801-1-wangkefeng.wang@huawei.com>
 <8852788c-3a10-ff28-2ff5-f35f5a736d64@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8852788c-3a10-ff28-2ff5-f35f5a736d64@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:26:17AM +0800, Kefeng Wang wrote:
> 
> On 2022/6/29 17:35, Kefeng Wang wrote:
> > Let's enable ACPI_HMAT, ACPI_HOTPLUG_MEMORY, MEMORY_HOTPLUG
> > and MEMORY_HOTREMOVE for more test coverage, also there are
> > useful for heterogeneous memory scene.
> 
> Hi Catalin and Will，is the defconfig patch picked up from you directly，
> the changelog shows most of them merged by SoC maintainers, but this
> one is some general feature, I don't know who will take it, thanks.

In general we leave the defconfig patches to the SoC team to avoid
conflicts as they have a lot more changes. Cc'ing Arnd if he wants to
pick it up, otherwise it can go through the arm64 tree.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
