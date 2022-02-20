Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AD5C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Feb 2022 23:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245247AbiBTXqR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 18:46:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiBTXqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 18:46:14 -0500
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com [192.185.143.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7034B85B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:45:52 -0800 (PST)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 2F45C1E1AA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 17:45:52 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id LvtonkRfBHnotLvtonZdlY; Sun, 20 Feb 2022 17:45:52 -0600
X-Authority-Reason: nr=8
Received: from host-95-232-30-176.retail.telecomitalia.it ([95.232.30.176]:34174 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nLvtn-0039ks-MT; Sun, 20 Feb 2022 17:45:51 -0600
Message-ID: <cf789d1c-48a9-cf16-5110-2bcdf2316d97@kernel.org>
Date:   Mon, 21 Feb 2022 00:45:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tracing: Dump stacktrace trigger to the corresponding
 instance
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
References: <afbb0b4f18ba92c276865bc97204d438473f4ebc.1645396236.git.bristot@kernel.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <afbb0b4f18ba92c276865bc97204d438473f4ebc.1645396236.git.bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.232.30.176
X-Source-L: No
X-Exim-ID: 1nLvtn-0039ks-MT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-232-30-176.retail.telecomitalia.it ([10.0.0.45]) [95.232.30.176]:34174
X-Source-Auth: kernel@bristot.me
X-Email-Count: 3
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/22 23:49, Daniel Bristot de Oliveira wrote:
> The stacktrace event trigger is dumping the stacktrace to the instance
> where it was enabled, but to the global "instance."

Oops,

The stacktrace event trigger is *NOT* dumping...

-- Daniel
