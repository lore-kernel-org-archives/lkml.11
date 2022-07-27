Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD9BC19F21
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jul 2022 05:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiG0Fxh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jul 2022 01:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiG0Fxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 01:53:34 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6608C1DA6E;
        Tue, 26 Jul 2022 22:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658901212; x=1690437212;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LyEC9mw6sBS6JblHLfS1Uqoakb0ZWXuzjTbMTRjUIsU=;
  b=IJCvyeUHvoswKfATQlIlRQB+PT0tT5E84V7NZXP5Db6TC1STZoLeZK7X
   iM6HArSaZ+Dqy9+YuC+M8Q/AHa4onzeoOLuiSN8eViv4vKSu+Eh5zYbci
   G+JrXU7z5IYDJxDKWle+jjZM48oI4GclFvZwb12sRZCeoJZ+2qaXHtVnQ
   I=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 Jul 2022 22:53:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 22:53:31 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Jul 2022 22:53:31 -0700
Received: from [10.50.42.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Jul
 2022 22:53:27 -0700
Message-ID: <accfe326-3998-8e93-791c-34369614ce3e@quicinc.com>
Date:   Wed, 27 Jul 2022 11:23:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V6 3/5] dt-bindings: clock: Add resets for LPASS audio
 clock controller for SC7280
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <quic_tdas@quicinc.com>
References: <1658315023-3336-1-git-send-email-quic_c_skakit@quicinc.com>
 <1658315023-3336-4-git-send-email-quic_c_skakit@quicinc.com>
 <20220727013026.8B3DCC433D7@smtp.kernel.org>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <20220727013026.8B3DCC433D7@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/27/2022 7:00 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-07-20 04:03:41)
>> From: Taniya Das <quic_tdas@quicinc.com>
>>
>> Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
>> for SC7280. Update reg property min/max items in YAML schema.
>>
>> Fixes: 4185b27b3bef ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280").
> BTW, that period at the end of the fixes line should be removed.


Okay.

