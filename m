Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDA3C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 08:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345842AbiCOIYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 04:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240254AbiCOIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:24:08 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 87C432725;
        Tue, 15 Mar 2022 01:22:52 -0700 (PDT)
Received: from [7.249.230.35] (unknown [119.3.119.18])
        by mail-app3 (Coremail) with SMTP id cC_KCgCnfqTGTDBiR4QHAA--.32091S3;
        Tue, 15 Mar 2022 16:22:32 +0800 (CST)
Message-ID: <87d57430-740c-dc1b-4a25-a9910e29b28a@zju.edu.cn>
Date:   Tue, 15 Mar 2022 16:22:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
To:     lostway@zju.edu.cn
Cc:     bp@alien8.de, james.morse@arm.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com
References: <20220214030813.135766-1-lostway@zju.edu.cn>
Subject: Re: [PATCH v3] RAS: Report ARM processor information to userspace
Content-Language: en-US
From:   Shengwei Luo <lostway@zju.edu.cn>
In-Reply-To: <20220214030813.135766-1-lostway@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cC_KCgCnfqTGTDBiR4QHAA--.32091S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUoA7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aV
        CY1x0267AKxVW0oVCq3wAa7VA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3VA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s0E7I0Y6sxI4wAa7VA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW0oVCq3VA2z4x0Y4vEx4A2jsIE14v26rxl6s0q6x02cVCv0xWlnx0E84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_GcCE3s0E7I0Y6sxI4wAS0I0E0xvYzxvE52x082IY62kv0487Mc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
        wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc
        8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIY
        CTnIWIevJa73UjIFyTuYvjfUcksgUUUUU
X-CM-SenderInfo: isrxjjaqquq6lmxovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Could I have some comments?

Thanks,
Shengwei Luo

