Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFAFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Feb 2022 17:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351124AbiBDRrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 12:47:16 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.33]:44301 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377121AbiBDRrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:47:14 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id D13A315EDF1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:47:05 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id G2fpnH28BXvvJG2fpnmRxa; Fri, 04 Feb 2022 11:47:05 -0600
X-Authority-Reason: nr=8
Received: from host-79-47-126-144.retail.telecomitalia.it ([79.47.126.144]:51660 helo=[10.0.1.2])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nG2fp-0022hu-7t; Fri, 04 Feb 2022 11:47:05 -0600
Message-ID: <23e7889f-9bb4-f607-630f-6f8f0ef90d3d@kernel.org>
Date:   Fri, 4 Feb 2022 18:46:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] rtla/osnoise: Fix segmentation fault when failing to
 enable -t
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
References: <cover.1643990447.git.bristot@kernel.org>
 <264ff7941b7551ec0b6e5862e40cf3dd593d0ff0.1643990447.git.bristot@kernel.org>
 <20220204124426.54d82ce2@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220204124426.54d82ce2@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.47.126.144
X-Source-L: No
X-Exim-ID: 1nG2fp-0022hu-7t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-47-126-144.retail.telecomitalia.it ([10.0.1.2]) [79.47.126.144]:51660
X-Source-Auth: kernel@bristot.me
X-Email-Count: 2
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 18:44, Steven Rostedt wrote:
> On Fri,  4 Feb 2022 17:24:05 +0100
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> --- a/tools/tracing/rtla/src/osnoise.c
>> +++ b/tools/tracing/rtla/src/osnoise.c
>> @@ -750,6 +750,9 @@ void osnoise_put_context(struct osnoise_context *context)
>>   */
>>  void osnoise_destroy_tool(struct osnoise_tool *top)
>>  {
>> +	if (!top)
>> +		return;
>> +
>>  	trace_instance_destroy(&top->trace);
>>  
>>  	if (top->context)
> Um, don't you still need to initialize everything to NULL?
> 
> i.e.
> 
> nt osnoise_top_main(int argc, char **argv)
> {
>         struct osnoise_top_params *params;
>         struct trace_instance *trace;
>         struct osnoise_tool *record;
>         struct osnoise_tool *tool;
>         int return_value = 1;
>         int retval;
> 
> 
> 
> Does not guarantee that record and tool will be initialized to NULL.

Aaarrrg, you're right.

As this is not related to the other patches, could you just ignore this one, so
I can re-send alone?

-- Daniel
