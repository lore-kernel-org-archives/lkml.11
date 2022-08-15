Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562BBC00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 16:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiHOQRA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 12:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiHOQQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:16:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08E211166
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:16:52 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M5znG2mPTz67XGx;
        Tue, 16 Aug 2022 00:12:02 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 18:16:50 +0200
Received: from [10.48.150.107] (10.48.150.107) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 17:16:49 +0100
Message-ID: <b83244b2-8881-bd74-a7e1-33006b42a636@huawei.com>
Date:   Mon, 15 Aug 2022 17:16:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/4] bus: hisi_lpc: Don't dereference fwnode handle
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "xuwei (O)" <xuwei5@huawei.com>
References: <20220708210859.6774-1-andriy.shevchenko@linux.intel.com>
 <f1d58027-099c-0486-0433-f97ec64ecfb7@huawei.com>
 <CAHp75Vf1JmkJ06np18+iTb+U7RZtbFQTRg-COyc+-V6URSsfZA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAHp75Vf1JmkJ06np18+iTb+U7RZtbFQTRg-COyc+-V6URSsfZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.150.107]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 09:59, Andy Shevchenko wrote:
> On Mon, Jul 11, 2022 at 10:17 AM John Garry <john.garry@huawei.com> wrote:
>>
>> Andy, Thanks for this work. I am not sure if you are hoping that Rafael
>> picks up this series also. JFYI, I would normally route any changes to
>> this driver through the arm soc tree via xuwei5@huawei.com, but if we
>> want to try that it may take an extra cycle now.
> 
> The series has been inspired by the recent work Rafael has done
> regarding some ACPI API changes. It's not critical per se and can be
> routed as the best for all maintainers.
> 
> 

Hi Andy,

I'll pick these up to be sent upstream by xu wei through the arm-soc 
tree. I will also do 2x things:
a. Send separate PoC series factor out the ACPI platform code, which I 
assume you and Rafael will agree is not worth pursuing
b. Add a patch to convert this driver to use 
platform_device_register_full(). This obviously conflicts with a.

Thanks,
John

BTW, A copy letter helps in scenarios like this....
