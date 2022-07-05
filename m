Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A73C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 14:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiGEOxP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 10:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiGEOxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:53:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6A413F05
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:53:12 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lclw706Yfz6H6sF;
        Tue,  5 Jul 2022 22:50:31 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 16:53:10 +0200
Received: from [10.126.171.232] (10.126.171.232) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 15:53:09 +0100
Message-ID: <604847cb-13d5-0def-f766-2cefb506f8c6@huawei.com>
Date:   Tue, 5 Jul 2022 15:53:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1 3/4] bus: hisi_lpc: Correct error code for timeout
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
 <20220705114312.86164-3-andriy.shevchenko@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220705114312.86164-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.171.232]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 12:43, Andy Shevchenko wrote:
> The usual error code is -ETIMEDOUT, the currently used -ETIME is specific
> for timers.
> 
> Signed-off-by: Andy Shevchenko<andriy.shevchenko@linux.intel.com>

Acked-by: John Garry <john.garry@huawei.com>
