Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A908C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 01:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1843843AbiDFBmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 21:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449039AbiDEPtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:49:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25A371AAFE8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:32:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 784AE23A;
        Tue,  5 Apr 2022 07:32:51 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C3CC33F5A1;
        Tue,  5 Apr 2022 07:32:50 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fix sorting of retrieved clock rates
Date:   Tue,  5 Apr 2022 15:32:48 +0100
Message-Id: <164916896262.1245964.759396458179093789.b4-ty@arm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318092813.49283-1-cristian.marussi@arm.com>
References: <20220318092813.49283-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 09:28:13 +0000, Cristian Marussi wrote:
> During SCMI Clock protocol initialization, after having retrieved from the
> SCMI platform all the available discrete rates for a specific clock, the
> clock rates array is sorted, unfortunately using a pointer to its end as
> a base instead of its start, so that sorting does not work.
> 
> Fix invocation of sort() passing as base a pointer to the start of the
> retrieved clock rates array.
> 
> [...]

Applied to sudeep.holla/linux (fixes/scmi), thanks!

[1/1] firmware: arm_scmi: Fix sorting of retrieved clock rates
      https://git.kernel.org/sudeep.holla/c/23274739a5

--
Regards,
Sudeep

