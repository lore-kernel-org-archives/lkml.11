Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C12EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 14:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbiBOOjA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 09:39:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiBOOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:38:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2938C102405
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:38:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA9E71396;
        Tue, 15 Feb 2022 06:38:48 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2970B3F718;
        Tue, 15 Feb 2022 06:38:48 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Alyssa Ross <hi@alyssa.is>
Subject: Re: [PATCH][REPOST] firmware: arm_scmi: Remove space in MODULE_ALIAS name
Date:   Tue, 15 Feb 2022 14:38:36 +0000
Message-Id: <164485073724.2376958.20415753652688371.b4-ty@arm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211102704.128354-1-sudeep.holla@arm.com>
References: <20220211102704.128354-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 10:27:04 +0000, Sudeep Holla wrote:
> From: Alyssa Ross <hi@alyssa.is>
> 
> modprobe can't handle spaces in aliases. Get rid of it to fix the issue.
> 

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Remove space in MODULE_ALIAS name
      https://git.kernel.org/sudeep.holla/c/1ba603f565

--
Regards,
Sudeep

