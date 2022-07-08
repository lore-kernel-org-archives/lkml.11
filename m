Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DA6CCA47B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 14:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiGHOtB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 10:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbiGHOsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:48:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5067C1A04D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:47:42 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LfbfC1VPtz6H7Lb;
        Fri,  8 Jul 2022 22:44:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 16:47:39 +0200
Received: from [10.195.34.23] (10.195.34.23) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Jul
 2022 15:47:39 +0100
Message-ID: <09df26a9-27af-1276-34c6-820bf7e27da8@huawei.com>
Date:   Fri, 8 Jul 2022 15:47:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
To:     <jpoimboe@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Subject: faddr2line issue
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.34.23]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

I am finding that for a few mainline kernel releases that faddr2line 
does seem to be working:

./scripts/faddr2line vmlinux  sas_discover_domain+0x4dc/0x560
sas_discover_domain+0x4dc/0x560:
fs mm ??:0

This is on my arm64 system. I have not tried another arch. Are there any 
known issues?

Maybe I'm using it incorrectly... I can go back and see when this 
stopped working for me.

Cheers,
John
