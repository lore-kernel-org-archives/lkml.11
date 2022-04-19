Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E219C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 07:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349512AbiDSHpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 03:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiDSHpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:45:36 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38B3014087
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:51 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id 9D82A1E80D17;
        Tue, 19 Apr 2022 15:40:38 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i4hBYJhLQfsH; Tue, 19 Apr 2022 15:40:36 +0800 (CST)
Received: from [172.30.21.106] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id B1EE21E80D14;
        Tue, 19 Apr 2022 15:40:35 +0800 (CST)
Subject: Re: [PATCH] arch/x86: use 'NULL' insteadof '0' as null pointer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, yuzhe@nfschina.com,
        renyu@nfschina.com
References: <20220417154148.541485-1-liqiong@nfschina.com>
 <20220419073732.GJ2731@worktop.programming.kicks-ass.net>
From:   liqiong <liqiong@nfschina.com>
Message-ID: <3989f258-d5fb-e379-a16f-6c9a124cdcbd@nfschina.com>
Date:   Tue, 19 Apr 2022 15:42:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20220419073732.GJ2731@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022年04月19日 15:37, Peter Zijlstra 写道:
> On Sun, Apr 17, 2022 at 11:41:48PM +0800, liqiong wrote:
>> Sparse warns: "Using plain integer as NULL pointer".
> What's wrong with that?

Just a sparse warning.



