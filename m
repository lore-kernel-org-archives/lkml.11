Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA2DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 10:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbiDYKKi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 06:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiDYKKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:10:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C96CA3630F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:06:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4831B1FB;
        Mon, 25 Apr 2022 03:06:42 -0700 (PDT)
Received: from bogus (unknown [10.57.11.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63E843F73B;
        Mon, 25 Apr 2022 03:06:40 -0700 (PDT)
Date:   Mon, 25 Apr 2022 11:06:35 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
        peterz@infradead.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH V2] arm64: add SCHED_CLUSTER's dependency on ACPI
Message-ID: <20220425100635.ig4dxvlflglfagpx@bogus>
References: <1650855303-91388-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650855303-91388-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 07:55:01PM -0700, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> cluster sched_domain configured by cpu_topology[].cluster_sibling, 
> which is set by cluster_id, cluster_id can only get from ACPI.
> 
> If the system does not enable ACPI, cluster_id is always -1, even enable
> SCHED_CLUSTER is invalid, this is misleading. 
> 
> So we add SCHED_CLUSTER's dependency on ACPI here.
>

Any reason why this can't be extended to support DT based systems via
cpu-map in the device tree. IMO we almost have everything w.r.t topology
in DT and no reason to deviate this feature between ACPI and DT.

-- 
Regards,
Sudeep
