Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878B1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 12:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349249AbiETMbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 08:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243910AbiETMbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:31:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C6E6B2273
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:31:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AF1C1477;
        Fri, 20 May 2022 05:31:37 -0700 (PDT)
Received: from [172.29.1.145] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6CB23F718;
        Fri, 20 May 2022 05:31:33 -0700 (PDT)
Message-ID: <d4c7fd09-814a-e57a-fe8f-a3959472991b@arm.com>
Date:   Fri, 20 May 2022 14:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/8] arch_topology: Don't set cluster identifier as
 physical package identifier
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atishp@atishpatra.org>,
        linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
References: <20220518093325.2070336-1-sudeep.holla@arm.com>
 <20220518093325.2070336-2-sudeep.holla@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220518093325.2070336-2-sudeep.holla@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 11:33, Sudeep Holla wrote:

You say `cluster identifier` which to me refers to
`cpu_topology[cpu].cluster_id`. But I guess you meant `cluster node`
from cpu-map DT node?

Otherwise you say we link (1.level) cpu-map cluster nodes to
`cluster_id\_sibling`? But then (1) we will never support nested
clusters and (2) why would we need llc support then?

[...]
