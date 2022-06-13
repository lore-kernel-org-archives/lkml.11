Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A57C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 03:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbiFMDuy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jun 2022 23:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiFMDuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 23:50:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580FB193EF;
        Sun, 12 Jun 2022 20:50:50 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LLyFH4SkkzRj1f;
        Mon, 13 Jun 2022 11:47:31 +0800 (CST)
Received: from [10.67.111.227] (10.67.111.227) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 11:50:47 +0800
Subject: Re: [PATCH] clk: qcom: clk-rpmh: Fix if statement to match comment
To:     Stephen Boyd <sboyd@kernel.org>, <quic_tdas@quicinc.com>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220531094539.252642-1-lizhengyu3@huawei.com>
 <20220610195856.A2D7EC3411C@smtp.kernel.org>
From:   "lizhengyu (E)" <lizhengyu3@huawei.com>
Message-ID: <788c25d7-0968-9d69-7753-d7cb8010a9f5@huawei.com>
Date:   Mon, 13 Jun 2022 11:50:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220610195856.A2D7EC3411C@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Jun 2022 12:58:54 -0700, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Li Zhengyu (2022-05-31 02:45:39)
>> (c->state) is u32, (enable) is bool. It returns false when
>> (c->state) > 1 and (enable) is true. Convert (c->state) to bool.
>>
>> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
> Nice catch! It looks like it fixes an optimization, where we don't want
> to run through and check has_state_changed() if this clk is already
> enabled or disabled. But how does this ever happen? The clk framework
> already reference counts prepare/unprepare, so how can we get into this
> function when the condition would be true, after this patch?
>
> I think we can simply remove the if condition entirely. Do you agree?

Sure. It seems Taniya Das (also I) hasn't mind the prepare/unprepare

of clk framework. As the result,  this if condition should be never true.

I will send a patch to remove it.

>> ---
>>   drivers/clk/qcom/clk-rpmh.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>> index aed907982344..851e127432a9 100644
>> --- a/drivers/clk/qcom/clk-rpmh.c
>> +++ b/drivers/clk/qcom/clk-rpmh.c
>> @@ -196,7 +196,7 @@ static int clk_rpmh_aggregate_state_send_command(struct clk_rpmh *c,
>>          int ret;
>>   
>>          /* Nothing required to be done if already off or on */
>> -       if (enable == c->state)
>> +       if (enable == !!c->state)
>>                  return 0;
>>   
>>          c->state = enable ? c->valid_state_mask : 0;
> .
