Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C8DC48BCB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381714AbiDDVXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379167AbiDDQiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:38:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F62230F58
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:36:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A9F214BF;
        Mon,  4 Apr 2022 09:36:12 -0700 (PDT)
Received: from [10.57.24.6] (unknown [10.57.24.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22ECF3F73B;
        Mon,  4 Apr 2022 09:36:10 -0700 (PDT)
Message-ID: <139c43f1-a711-5e14-eb88-3f65c8a328ad@arm.com>
Date:   Mon, 4 Apr 2022 17:36:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Content-Language: en-US
To:     Jamie Iles <quic_jiles@quicinc.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
References: <20220217182110.7176-1-james.morse@arm.com>
 <YiYAfiSZg6uNlwPN@hazel>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <YiYAfiSZg6uNlwPN@hazel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamie,

On 3/7/22 12:56, Jamie Iles wrote:
> On Thu, Feb 17, 2022 at 06:20:49PM +0000, James Morse wrote:
>> Changes in this version? Expanded the commit message of patch 12, and
>> made a few things static, as reported by the kbuild robot.

[...]

> Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>

Thanks!

James
